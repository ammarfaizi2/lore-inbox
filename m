Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268049AbUG2PQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268049AbUG2PQr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268048AbUG2PNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:13:35 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:57861 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264966AbUG2Oc2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:32:28 -0400
Date: Thu, 29 Jul 2004 16:32:26 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.8-rc1-mm1] decode local APIC errors
In-Reply-To: <200407272036.i6RKatf1013827@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.58L.0407291621150.18647@blysk.ds.pg.gda.pl>
References: <200407272036.i6RKatf1013827@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004, Mikael Pettersson wrote:

> You're right, separate printk()s don't work, and formatting the
> text to a buffer gets into other problems(*).
> 
> Andrew, please feel free to toss my crappy patch in /dev/null...

 As I've written, I'm not against it in principle, e.g. feel free to 
recode it to log something like this:

<3>APIC: error on CPU0: 05(04)
<7>APIC:   01: Send Checksum Error
<7>APIC:   04: Send Accept Error
<7>APIC:  (04: Send Accept Error)

or anything sensible more or less similar.  The example doesn't require
any temporary hold space.

  Maciej
