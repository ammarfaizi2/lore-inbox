Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161491AbWJaAfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161491AbWJaAfo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 19:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161493AbWJaAfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 19:35:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33416 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161491AbWJaAfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 19:35:43 -0500
Date: Mon, 30 Oct 2006 16:34:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: sylvain.bertrand@gmail.com
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Chris Wedgwood <cw@f00f.org>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>
Subject: Re: [Bugme-new] [Bug 7437] New: VIA VT8233 seems to suffer from the
 via latency quirk
Message-Id: <20061030163458.4fb8cee1.akpm@osdl.org>
In-Reply-To: <200610310020.k9V0KGQK003237@fire-2.osdl.org>
References: <200610310020.k9V0KGQK003237@fire-2.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(switched to email - please retain all cc's)

On Mon, 30 Oct 2006 16:20:16 -0800
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=7437
> 
>            Summary: VIA VT8233 seems to suffer from the via latency quirk
>     Kernel Version: 2.6.19-rc3
>             Status: NEW
>           Severity: normal
>              Owner: greg@kroah.com
>          Submitter: sylvain.bertrand@gmail.com
> 
> 
> Most recent kernel where this bug did not occur: 2.6.19-rc3

Nope.  We're asking which kernel did _not_ have this bug?

> Distribution: All
> Hardware Environment: ASUS A7V266-E motherboad (northbridge VIA KT266A,
> southbridge VIA 8233), PCI SB LIVE!, onboard promise IDE controller, additional
> PCI USB2 card.
> Software Environment: any
> 
> Problem Description: Fear to load the PCI bus, because it seems to cause a hard
> crash with hard drive data corruption. Too much similar to quirk_vialatency in 
> drivers/pci/quirks.c (see description line 163) to be innocent.
> 
> Steps to reproduce: Load the PCI bus with, for instance, a big file transfer
> from an usb mass storage media v2 connected on a PCI USB2 card to the main hard
> drive and at the same time play music. Randomly crashes the computer and
> corrupts hard drive data (sometimes beyond repair).
> 

argh.  Are you able to identify a change to the via quirk-handling code
which prevents this from happening?

