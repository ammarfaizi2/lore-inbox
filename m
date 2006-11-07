Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965603AbWKGRff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965603AbWKGRff (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 12:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965606AbWKGRff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 12:35:35 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:1440 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S965603AbWKGRfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 12:35:34 -0500
Date: Tue, 7 Nov 2006 18:31:16 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Paul Rolland <rol@as2917.net>
cc: "'Marc Perkel'" <marc@perkel.com>,
       "'Chris Lalancette'" <clalance@redhat.com>,
       "'Rafael J. Wysocki'" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: RE: could not find filesystem /dev/root
In-Reply-To: <00da01c70287$aa8c2420$4b00a8c0@donald>
Message-ID: <Pine.LNX.4.61.0611071830100.22309@yvahk01.tjqt.qr>
References: <00da01c70287$aa8c2420$4b00a8c0@donald>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>   On the other side, you can run udev _once_ to create device 
>> nodes like 
>> /dev/disk/by-label/ to allow at least correct booting (possibly using 
>> LABEL=) Once the box is up, one can always figure out which drive is 
>> which by looking at fdisk or other info. (Gets a little hard when 
>> they're all the same manufacturer and type, but then again, LABEL= 
>> will work without udev in the "normal" userspace.)
>
>I may give it a try... Using uuid could also be an option but I'm not
>sure this can be configured thru fstab...

To mount disks using LABEL= or UUID=, as far as I know, you need either
blkid or guessfstype, or a /dev/disk/by-{label,uuid}/ symlink. This 
should work even when there is no udev running.


	-`J'
-- 
