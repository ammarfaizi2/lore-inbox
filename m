Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946271AbWJSRr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946271AbWJSRr5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946272AbWJSRr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:47:57 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:743 "EHLO gundega.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1946271AbWJSRr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:47:56 -0400
Date: Thu, 19 Oct 2006 10:47:28 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: Mariusz Kozlowski <m.kozlowski@tuxland.pl>, linux-kernel@vger.kernel.org,
       "John W. Linville" <linville@tuxdriver.com>
Subject: Re: 2.6.19-rc2-mm1 // errors in verify_redzone_free()
Message-ID: <20061019174728.GA9435@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20061016230645.fed53c5b.akpm@osdl.org> <200610191645.40308.m.kozlowski@tuxland.pl> <20061019100342.4e4895fb.akpm@osdl.org> <20061019171727.GA9350@bougret.hpl.hp.com> <20061019102529.dea90fec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061019102529.dea90fec.akpm@osdl.org>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 10:25:29AM -0700, Andrew Morton wrote:
> > 
> > 	Do you know which driver the user is using ? Is it an
> > in-kernel driver, or an out-of-kernel driver ?
> > 	Thanks !
> > 
> 
> Modules Loaded         orinoco_cs orinoco hermes pcmcia firmware_class 
> yenta_socket rsrc_nonstatic pcmcia_core
> 
> The full dmesg is on the mailing list - I'll forward it to you.

	It's the same bug as before.
	The user is *not* using 2.6.19-rc2-mm1, but 2.6.19-rc2 :
---------------------------------------------------
Linux version 2.6.19-rc2 (root@orion) (gcc version 4.1.1 (Gentoo 4.1.1)) #3 PREEMPT Thu Oct 19 16:04:17 CEST 2006
---------------------------------------------------
	The Orinoco fix is in 2.6.19-rc2-mm1, but it is *not* in
2.6.19-rc2.

	John : the current code is 2.6.19-rc2 is definitely not
releasable. Either we back out WE-21, or we fix it, but doing nothing
at this point is a receipe for disaster.

	I submitted to you 3 patches to fix WE-21 in 2.6.19-rc2 :
		o Orinoco SLAB fix
		o Other driver slab fix
		o WE-20 ESSID backward compatibility
	Those patches were fixing real problems and tested on my side.
	If those patches are not planned to go in 2.6.19-rc2, I ask
again that WE-21 be removed from 2.6.19.

	Thanks in advance...

	Jean
