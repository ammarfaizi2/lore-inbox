Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbTEPWY6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 18:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263759AbTEPWY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 18:24:58 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:22262 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263444AbTEPWY5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 18:24:57 -0400
Date: Fri, 16 May 2003 15:39:08 -0700
From: Greg KH <greg@kroah.com>
To: Pavel Roskin <proski@gnu.org>
Cc: Manuel Estrada Sainz <ranty@debian.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>,
       Jean Tourrilhes <jt@hpl.hp.com>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030516223908.GA16870@kroah.com>
References: <20030515200324.GB12949@ranty.ddts.net> <Pine.LNX.4.55.0305151623520.2885@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0305151623520.2885@marabou.research.att.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 04:38:58PM -0400, Pavel Roskin wrote:
> I wrote this private already, but it needs to be said now.  It's not
> _caching_ that is needed.  What is needed is a filesystem that can be
> populated in the kernel binary.

initramfs can do this today.  It isn't the issue for this firmware
interface to solve.  Same thing goes for the "resume the sleeping
device" arguement.  That's not this code's issue.

> Can I use this code to replace broken ACPI table (DSDT) I have in some of
> my systems?

Hm, don't know the ACPI startup point in reference to when initramfs
gets uncompressed.  But I think you might be safe.

> Can I use this code to load firmware into my SCSI adapter if
> I need it to access the only disk in the system?

With initramfs, yes.

> Can I use this code to program a network interface I'm going to use
> for root over NFS?

Again, with initramfs, yes.

thanks,

greg k-h
