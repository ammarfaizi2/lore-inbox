Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbULIQVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbULIQVu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 11:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbULIQVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 11:21:50 -0500
Received: from cpe-66-27-170-242.socal.rr.com ([66.27.170.242]:15540 "EHLO
	bsd.clones.net") by vger.kernel.org with ESMTP id S261540AbULIQVr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 11:21:47 -0500
Date: Thu, 9 Dec 2004 08:21:50 -0800 (PST)
From: Glendon Gross <gross@clones.net>
To: linux-kernel@vger.kernel.org
cc: glendon144@hotmail.com
Subject: Burning CD's and 2.6.9 
Message-ID: <Pine.NEB.4.44.0412090810570.27084-100000@bsd.clones.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just built 2.6.9 and have been playing with the config to try to enable
support for my EMPREX 8x DVD burner.  It works exceptionally well under
2.4.26.   I can use cdrecord and also growisofs to make audio and data
DVD's.

I read a little of the discussion about the new devfs code on the list
archive.  I respect Linus' stated desires to avoid an unnecessary HAL in
the dev filesystem.  So I'm wondering, is it time to write a new CD and
DVD low-level authoring tool to replace cdrecord, such as FreeBSD's
"burncd"?   What I've always liked about cdrecord is not the SCSI
numbering system (although it works well under 2.4.26 because my SCSI
emulation shows up as the 2nd SCSI "bus", as in the following:

Script started on Thu 09 Dec 2004 08:16:51 AM PST
root@optiplex:/home/gross# cdrecord -sb canbus
Cdrecord-Clone 2.01 (i686-pc-linux-gnu) Copyright (C) 1995-2004 Jörg Schilling
Linux sg driver version: 3.1.25
Using libscg version 'schily-0.8'.
scsibus1:
	1,0,0	100) *
	1,1,0	101) *
	1,2,0	102) *
	1,3,0	103) 'IBM     ' 'DDRS-34560      ' 'S97B' Disk
	1,4,0	104) *
	1,5,0	105) *
	1,6,0	106) *
	1,7,0	107) *
scsibus2:
	2,0,0	200) 'DVDRW   ' 'IDE1008         ' '0055' Removable CD-ROM
	2,1,0	201) *
	2,2,0	202) *
	2,3,0	203) *
	2,4,0	204) *
	2,5,0	205) *
	2,6,0	206) *
	2,7,0	207) *
root@optiplex:/home/gross# uname -a
Linux optiplex 2.4.26 #2 Mon Jun 14 19:05:05 PDT 2004 i686 unknown unknown GNU/Linux
root@optiplex:/home/gross# exit

Script done on Thu 09 Dec 2004 08:17:01 AM PST

I've set up a lilo config menu to boot 2.6.9 or 2.4.26 because the device
is not recognized under 2.6.9.    When it is recognized, I get a warning
that ide-scsi is deprecated for cd recording.

So what do you think, is it time to write a general tool for audio CD
authoring that has all the features of cdrecord?  What I like about
cdrecord is not the interface but rather the hardware-specific features
that just about guarantee that any drive will work.


Regards,

Glendon Gross
Linux and Unix Enthusiast
http://clones.net

