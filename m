Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbTKVR2d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 12:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbTKVR2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 12:28:33 -0500
Received: from nibbel.kulnet.kuleuven.ac.be ([134.58.240.41]:11148 "EHLO
	nibbel.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S262410AbTKVR2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 12:28:31 -0500
From: Frank Dekervel <kervel@drie.kotnet.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test9-mm4 (does not boot)
Date: Sat, 22 Nov 2003 18:28:28 +0100
User-Agent: KMail/1.5.93
Cc: linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>
References: <200311191749.28327.kervel@drie.kotnet.org> <200311201137.55553.kervel@drie.kotnet.org> <20031120072236.68327dca.akpm@osdl.org>
In-Reply-To: <20031120072236.68327dca.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200311221828.28945.kervel@drie.kotnet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

> mm4 pnpbios gives the same numbers, but never says 
> PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
> instead it says general protection fault
> 

> There are three pnpbios patches in -mm:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm4/broken-out/pnp-fix-1.patch

"With this patch, the PnPBIOS driver will read static resources 
 initially and then switch to dynamic mode when allocating 
 resources for specific nodes."

-> this one causes the trouble (general protection fault -> kernel panic) for me... without this patch
    my system boots (and recognises pnpbios) fine.

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm4/broken-out/pnp-fix-2.patch

"this patch provides an option for PnPBIOS calls to be 
 managed by the PnPBIOS driver exclusively" (no /proc support) 

-> cannot be this one, since i enabled /proc support

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm4/broken-out/pnp-fix-3.patch

-> not pnpbios related (isapnp)

greetings,
frank


-- 
Frank Dekervel - frank.dekervel@student.kuleuven.ac.be
Mechelsestraat 88
3000 Leuven (Belgium)
