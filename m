Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264735AbUDUES4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264735AbUDUES4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 00:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264709AbUDUES4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 00:18:56 -0400
Received: from smtp-out8.xs4all.nl ([194.109.24.9]:20496 "EHLO
	smtp-out8.xs4all.nl") by vger.kernel.org with ESMTP id S264735AbUDUEND
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 00:13:03 -0400
Date: Wed, 21 Apr 2004 06:13:08 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc1-mm1 (and earlier): pdflush taking 100% cpu time (profile, .config etc. provided)
Message-ID: <20040421041308.GA19740@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20040420203449.GA21351@middle.of.nowhere> <20040420191533.6af76eb2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040420191533.6af76eb2.akpm@osdl.org>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Tue, Apr 20, 2004 at 07:15:33PM -0700
> Jurriaan <thunder7@xs4all.nl> wrote:
> >
> >  at times, pdflush is taking over my system:
> 
> yup, there's some logic error in there.  If I could reproduce it, it would
> be fixed in a jiffy :(
> 
> Which filesystems are in active use at the time?  reiserfs?
> 

mostly, yes, also ext3, and raid-1 and linear raid. I can't always
reproduce it either, unfortunately :-(

/dev/md3 on / type ext3 (rw,errors=remount-ro)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
tmpfs on /dev/shm type tmpfs (rw)
usbfs on /proc/bus/usb type usbfs (rw)
/dev/md4 on /usr type ext3 (rw,errors=remount-ro)
/dev/md2 on /var type ext3 (rw,errors=remount-ro)
sysfs on /devices type sysfs (rw)
/dev/md5 on /vmware type reiserfs (rw)
/dev/md0 on /home type reiserfs (rw)
/dev/md1 on /var/spool/news_binary type reiserfs (rw)
/dev/hde1 on /space1 type reiserfs (rw,noexec,nosuid,nodev)
/dev/hdk1 on /space2 type reiserfs (rw,noexec,nosuid,nodev)
/dev/hdg1 on /space3 type reiserfs (rw,noexec,nosuid,nodev)

Personalities : [linear] [raid0] [raid1] [raid5] 
md3 : active raid1 hdc1[0] hda1[1]
      497856 blocks [2/2] [UU]
      
md4 : active raid1 hdc3[0] hda3[1]
      8008320 blocks [2/2] [UU]
      
md2 : active raid1 hdc5[0] hda5[1]
      16008640 blocks [2/2] [UU]
      
md5 : active raid1 hdc6[0] hda6[1]
      8008256 blocks [2/2] [UU]
      
md1 : active linear hdi1[2] hdc7[1] hda7[0]
      76909568 blocks 64k rounding
      
md0 : active raid1 hdc8[0] hda8[1]
      62645312 blocks [2/2] [UU]
      
unused devices: <none>

Kind regards,
Jurriaan
-- 
But what can you do with it?
	ubiquitous cry from Linux-user partner
Debian (Unstable) GNU/Linux 2.6.6-rc1-mm1 2x6062 bogomips load av: 2.07 2.06 2.17
