Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945914AbWBDLav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945914AbWBDLav (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 06:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945925AbWBDLav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 06:30:51 -0500
Received: from main.gmane.org ([80.91.229.2]:38052 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1945914AbWBDLau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 06:30:50 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mahesh <mahesh_chelen@yahoo.com>
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
Date: Sat, 4 Feb 2006 07:01:47 +0000 (UTC)
Message-ID: <loom.20060204T075631-490@post.gmane.org>
References: <d120d5000601090850k42cc1c1ft6ab4e197119cacd@mail.gmail.com>  <Pine.LNX.4.44L0.0601091215070.7432-100000@iolanthe.rowland.org> <d120d5000601090954k3e35c3c7n31d4d6796ac760bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 202.88.239.166 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.0.7-1.1.fc4 Firefox/1.0.7)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dmitry Torokhov <dmitry.torokhov <at> gmail.com> writes:

 
 On 1/9/06, Alan Stern <stern <at> rowland.harvard.edu> wrote:
 > On Mon, 9 Jan 2006, Dmitry Torokhov wrote:
 >
 > > > It would be nice to know which part of the usb-handoff code causes the
 > > > problem.
 > >
 > > Well, it's not handoff code causing problems per se, it's just that it
 > > does not look like it performs handoff. If it did then disabling USB
 > > legacy emulation in BIOS would have no effect, right?
 >
 > On the other hand, if the BIOS worked correctly then the ps/2 port would
 > have no problems regardless of whether USB legacy emulation was on or off.
 > Given that the keyboard works during bootup, I see only two possibilities:
 >
 >        The USB handoff code somehow causes the BIOS to mess up the
 >        state of the 8042;
 >
 >        The 8042 driver interacts badly with the firmware when USB
 >        legacy emulation is on, and the USB handoff code doesn't
 >        successfully turn off legacy emulation.
 >
 > My earlier suggestion was an attempt to test the first possibility.  The
 > second is harder to test because it implies problems in both the 8042
 > driver and the USB handoff code.
 >
 
 My experience is that USB legacy emulation in BIOS + ACPI works as
 long as you do not touch it and gets terribly confused if someone
 tries to actually use i8042 (like enable active multiplexing mode with
 4 AUX ports). As soon as BIOS takes its dirty hands off i8042
 everything works fine.
 
 The problem it seems that when usb-handoff code was moved from pci
 quirks and enabled inconditionally something happened so it stopped
 doing handoff.
 

 Dmitry
 
 
hi
I experienced same problem, but after complilng latest kernel the problem is
rectified. So I think problem with kernel 2.6.11,13 ..could be rectified by
compiling with a higher version of kernel.
regd
mahesh




