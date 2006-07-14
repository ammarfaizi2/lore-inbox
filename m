Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161115AbWGNOn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161115AbWGNOn0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 10:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161116AbWGNOn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 10:43:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8080 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161115AbWGNOnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 10:43:25 -0400
Date: Fri, 14 Jul 2006 07:43:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: greg@kroah.com, cw@f00f.org, harmon@ksu.edu, linux-kernel@vger.kernel.org,
       Daniel Drake <dsd@gentoo.org>
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
Message-Id: <20060714074305.1248b98e.akpm@osdl.org>
In-Reply-To: <44B78538.6030909@garzik.org>
References: <20060714095233.5678A8B6253@zog.reactivated.net>
	<44B77B1A.6060502@garzik.org>
	<44B78294.1070308@gentoo.org>
	<44B78538.6030909@garzik.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2006 07:51:20 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Daniel Drake wrote:
> > Jeff Garzik wrote:
> >> Daniel Drake wrote:
> >>> Gentoo users at http://bugs.gentoo.org/138036 reported a 2.6.16.17 
> >>> regression:
> >>> new kernels will not boot their system from their VIA SATA hardware.
> >>>
> >>> The solution is just to add the SATA device to the fixup list.
> >>> This should also fix the same problem reported by Scott J. Harmon on 
> >>> LKML.
> >>>
> >>> Signed-off-by: Daniel Drake <dsd@gentoo.org>
> >>
> >> Same NAK comment as before...
> > 
> > I didn't see this patch posted anywhere before, but I just did some more 
> > searching and found something similar. Are you referring to 
> > http://lkml.org/lkml/2006/6/24/184 ?
> 
> Same rationale, but the VIA SATA PCI ID had been submitted before, as 
> well...
> 

argh.  Is someone able to confirm that 2.6.18-rc1-mm2 works OK?  In that
kernel I did a desperation reversion of the offending patches
(revert-VIA-quirk-fixup-additional-PCI-IDs.patch and
revert-PCI-quirk-VIA-IRQ-fixup-should-only-run-for-VIA-southbridges.patch).

Guys, this is a really serious failure but afaict nobody is working on it
and generally nothing at all is happening.

How do we fix all this?  (Who owns it?)
