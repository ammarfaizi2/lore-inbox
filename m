Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbUJaC1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbUJaC1p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 22:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbUJaC1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 22:27:45 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:40149 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261476AbUJaC1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 22:27:32 -0400
Subject: Re: [BK PATCHES] ide-2.6 update
From: Kevin Freeman <kfreem02@comcast.net>
To: linux-kernel@vger.kernel.org
Cc: edmudama@gmail.com
Content-Type: text/plain
Date: Sat, 30 Oct 2004 21:27:25 -0500
Message-Id: <1099189645.26214.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric wrote:
> One of two things is happening: 
> 
> 1) Two drives are identically corrupted, producing the invalid serial
> numbers being reported in the ID block.  My belief is that this wasn't
> likely, given the low volume of reports.  The reported bad SN was
> "M0000000000000000000" which based on our firmware, I don't see how it
> could happen.  A corruption of the config sector (the most likely
> cause) *should* be catastrophic to the drive's functionality.
> 
> 2) There is a code or hardware bug somewhere outside of the drive
> itself that is causing this data to become corrupted.
> 
> Either way, I believe the best course of action is to RMA the drives
> for new ones.  I don't think good stuff will come from having the
> linux kernel use drives that appear to be broken.
> 
> It'd be nice to test these drives on more systems, or with a bus
> analyzer, to identify the cause.
> 
> --eric

I am experiencing the same problem with recent kernels.  This machine
has 2 Maxtor drives (4D080H4) with the same invalid serial number
( D4000000 ).  The machine was happily running Fedora Core 2 for quite
some time with no hard drive errors.  The drives themselves were
previously installed in a Windows XP machine, also without incident.
Note that in the current machine, Windows XP 64-bit beta Device Manager
also displays an error related to duplicate drive IDs.

System motherboard is a Chaintech VNF3-250 (NForce3). One drive is on
the onboard IDE controller, the other is attached to a Silicon Image PCI
IDE controller. Connecting both drives to the onboard IDE controller
under Linux results in the error message "ignoring undecoded slave"
and /dev/hdb is not available to the system.  Fedora kernel 2.6.8-1.521
(based on 2.6.8-rc4-bk3) was among the last to allow the system to boot
with both drives attached to the onboard IDE controller.

hdparm, dmesg output at:
http://home.comcast.net/~kfreem02/4D080H4/index.html

Please cc me on any followups.

Thanks,
Kevin Freeman

