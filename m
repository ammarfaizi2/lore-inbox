Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265978AbUFDU3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUFDU3L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 16:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265979AbUFDU3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 16:29:11 -0400
Received: from gnu-designs.com ([65.172.152.98]:32457 "EHLO
	mail.gnu-designs.com") by vger.kernel.org with ESMTP
	id S265978AbUFDU3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 16:29:08 -0400
Date: Fri, 4 Jun 2004 16:28:56 -0400 (EDT)
From: "David A. Desrosiers" <desrod@gnu-designs.com>
X-X-Sender: hacker@aphrodite.gnu-designs.com
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: USBDEVFS_RESET deadlocks USB bus.
In-Reply-To: <20040604200748.GA12855@kroah.com>
Message-ID: <Pine.LNX.4.58.0406041626190.8440@aphrodite.gnu-designs.com>
References: <20040604193911.GA3261@babylon.d2dc.net> <20040604195247.GA12688@kroah.com>
 <20040604200211.GB3261@babylon.d2dc.net> <20040604200748.GA12855@kroah.com>
X-Biography: http://www.gnu-designs.com/palm+linux/
X-Advogato: http://www.advogato.org/person/hacker
X-Sourcefubar: http://www.sourcefubar.net
X-GPG-Fingerprint: 125A 3A28 0F57 72F7 AF7B  67DF 9114 0446 7075 AE4A
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Sourcefubar-MailScanner: No infection
X-MailScanner-From: desrod@gnu-designs.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ah, can you not try the -mm1 kernel?  This problem should not be in the
> mainline kernel.  There was a locking issue in the last bk-usb patch that
> made it into the -mm1 kernel that was fixed yesterday.

	I can confirm that the last kernel this worked with was 2.6.6. We
can't get libusb working at all in 2.4 for the device detection (as you
know). I've now tried everything from 2.6.6 up to 2.6.7-rc2-mm2, including
all "official" (non-akpm) kernels in-between. Same issue.

	What I see in the logs, which may be of use, is:

May 31 21:38:08 wrath kernel: uhci_hcd 0000:00:1d.1: suspend_hc
May 31 21:38:08 wrath kernel: uhci_hcd 0000:00:1d.1: wakeup_hc
May 31 21:38:11 wrath kernel: uhci_hcd 0000:00:1d.1: suspend_hc
May 31 21:38:11 wrath kernel: uhci_hcd 0000:00:1d.1: wakeup_hc
May 31 21:38:13 wrath kernel: uhci_hcd 0000:00:1d.1: suspend_hc
May 31 21:38:13 wrath kernel: uhci_hcd 0000:00:1d.1: wakeup_hc

	..over and over and over, taking the system load gradually up, until
it no longer responds, and has to be rebooted forcibly.

d.

