Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWEZHkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWEZHkx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 03:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWEZHkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 03:40:53 -0400
Received: from cantor2.suse.de ([195.135.220.15]:16804 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750708AbWEZHkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 03:40:53 -0400
Message-ID: <4476B0F6.2000708@suse.de>
Date: Fri, 26 May 2006 09:40:38 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060411)
MIME-Version: 1.0
To: Magnus Damm <magnus@valinux.co.jp>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [Fastboot] [PATCH 03/03] kexec: Avoid overwriting the current
 pgd (V2, x86_64)
References: <20060524044232.14219.68240.sendpatchset@cherry.local>	 <20060524044247.14219.13579.sendpatchset@cherry.local>	 <m1slmystqa.fsf@ebiederm.dsl.xmission.com> <1148545616.5793.180.camel@localhost>
In-Reply-To: <1148545616.5793.180.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1a. The C-code in xen_machine_kexec() performs a hypercall.
> 
> 1b. The hypervisor jumps to the assembly code.
> After prepare we've created a NX-safe mapping for the control page. We
> jump to that NX-safe address to transfer control to the assembly code.

This is about kexec'ing the physical machine, not the virtual machine,
right?

cheers,

  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
http://www.suse.de/~kraxel/julika-dora.jpeg
