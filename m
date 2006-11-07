Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932652AbWKGOVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbWKGOVB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 09:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbWKGOVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 09:21:00 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:45440 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932652AbWKGOVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 09:21:00 -0500
Date: Tue, 7 Nov 2006 15:18:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Paul Rolland <rol@as2917.net>
cc: "'Marc Perkel'" <marc@perkel.com>,
       "'Chris Lalancette'" <clalance@redhat.com>,
       "'Rafael J. Wysocki'" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: RE: could not find filesystem /dev/root
In-Reply-To: <004001c70252$82702570$4b00a8c0@donald>
Message-ID: <Pine.LNX.4.61.0611071514270.11892@yvahk01.tjqt.qr>
References: <004001c70252$82702570$4b00a8c0@donald>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> If you don't want udev, make an initramfs, build your disk driver as 
>> modules, and load them in the order you want your disks numbered.
>> 
>> udev or initramfs, you ought to choose at least one.
>
>Nope, you don't. I'm now using a kernel without modules for what's disk 
>related, and unless people (read kernel developpers) change something 

Yeah, "unless". But the kernel should be considered fuzzy logic in 
this area :) after all, it does not even need a kernel developer -- a 
binutils contributor might also change something that results in a 
change of link order.

  On the other side, you can run udev _once_ to create device nodes like 
/dev/disk/by-label/ to allow at least correct booting (possibly using 
LABEL=) Once the box is up, one can always figure out which drive is 
which by looking at fdisk or other info. (Gets a little hard when 
they're all the same manufacturer and type, but then again, LABEL= 
will work without udev in the "normal" userspace.)

>in the init order, I'm now with a stable environment, without udev or
>initramfs.
>
>Paul
>

	-`J'
-- 
