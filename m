Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262672AbTCPOu6>; Sun, 16 Mar 2003 09:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262673AbTCPOu6>; Sun, 16 Mar 2003 09:50:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45981 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262672AbTCPOu5>;
	Sun, 16 Mar 2003 09:50:57 -0500
Date: Sun, 16 Mar 2003 15:01:48 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20: ext3/raid5 - allocating block in system zone/multiple 1 requests for sector
Message-ID: <20030316150148.GC1148@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 14:56:06 up 1 day,  3:22,  2 users,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I've just built an 800GB RAID5 array and built an ext3 file system
on it; on trying to copy data off the 200GB RAID it is replacing I'm
starting to see errors of the form:

kernel: EXT3-fs error (device md(9,2)): ext3_new_block: Allocating block in
system zone - block = 140509185

and

kernel: EXT3-fs error (device md(9,2)): ext3_add_entry: bad entry in
directory #70254593: rec_len %% 4 != 0 - offset=28, inode=23880564,
rec_len=21587, name_len=76

and

kernel: raid5: multiple 1 requests for sector 281018464

This is on an x86 which has been running fine on the smaller raid for
years (albeit Reiser); the array is built from 5 200GB Western Digi
IDEs on a mix of promise and HPT controllers (there are no IDE errors
visible). This is a straight 2.4.20 kernel.

The previous messages to the list with this form of error have suggested
the problem is related to >2TB arrays; but this one is a relative 
tiny one.

Help greatly appreciated,

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
