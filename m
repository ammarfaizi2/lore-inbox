Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136463AbRD3HHg>; Mon, 30 Apr 2001 03:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136464AbRD3HH1>; Mon, 30 Apr 2001 03:07:27 -0400
Received: from h24-76-184-93.vs.shawcable.net ([24.76.184.93]:29707 "EHLO
	candle.perlpimp.com") by vger.kernel.org with ESMTP
	id <S136463AbRD3HHO>; Mon, 30 Apr 2001 03:07:14 -0400
Date: Mon, 30 Apr 2001 00:07:04 -0700
From: putter <spam@perlpimp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: reiserfs autofix?
Message-ID: <20010430000704.A2313@vancouver.yi.org>
Reply-To: spam@perlpimp.com
In-Reply-To: <20010429144827.A751@vancouver.yi.org> <621300000.988584911@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <621300000.988584911@tiny>; from mason@suse.com on Sun, Apr 29, 2001 at 06:55:11PM -0400
X-Arbitrary-Number-Of-The-Day: 42
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I have tracked down the problem to the card itself. My machine is on @ graphics mode all the time,
like 24hrs a day, and it seems that it is somewhat taxing on the cards performance. So now I switch down to
text mode, everytime I leave the machine. How did I find out? I placed my finger of heatsink of my GeForce DDR.
It was HOT! Fan works alright, so if I was to run computer a while, stress accumilates, and when I run GeForce
understress of maximum resolutions, it craps out. So much for NVidia eh?

BTW, I don't question graphical subsystem crashes. I question reiserfs that suppose to leave my partitions
in consistent state, no matter how trigger happy with power switch I am, or is my judgement is clouded? >=)

So here's details....: Offending reiserfs messages, after last boot.

  2376  Apr 29 15:23:28 candle fancylogin: from /dev/tty1: ACCESS GRANTED: pavel logged in 
  2377  Apr 29 15:23:33 candle kernel: NVRM: loading NVIDIA kernel module version 1.0-769 
  2378  Apr 29 16:24:29 candle kernel: mtrr: no MTRR for e4000000,2000000 found 
  2379  Apr 29 16:24:45 candle kernel: mtrr: no MTRR for e4000000,2000000 found 
  2380  Apr 29 16:24:50 candle fancylogin: from /dev/tty1: ACCESS GRANTED: pavel logged in 
  2381  Apr 29 16:31:18 candle modprobe: modprobe: Can't locate module net-pf-10
  2382  Apr 29 18:01:02 candle kernel: vs-13042: reiserfs_read_inode2: [7772 8013 0x0 SD] not found 
  2383  Apr 29 18:01:02 candle kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (7772 8013) not found 
  2384  Apr 29 19:01:01 candle kernel: vs-13042: reiserfs_read_inode2: [7772 8013 0x0 SD] not found 
  2385  Apr 29 19:01:01 candle kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (7772 8013) not found 
  2386  Apr 29 20:01:00 candle kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (7772 8013) not found 
  2387  Apr 29 21:01:00 candle kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (7772 8013) not found 
  2388  Apr 29 22:01:01 candle kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (7772 8013) not found 
  2389  Apr 29 23:01:01 candle kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (7772 8013) not found 
  2390  Apr 29 23:52:55 candle sudo:    pavel : TTY=pts/1 ; PWD=/home/pavel ; USER=root ; COMMAND=/bin/su -
  2391  Apr 29 23:52:55 candle PAM_pwdb[2242]: (su) session opened for user root by pavel(uid=0)
  2392  Apr 29 23:53:07 candle PAM_pwdb[2263]: (su) session opened for user spam by pavel(uid=0)
  2393  Apr 29 23:54:42 candle PAM_pwdb[2263]: (su) session closed for user spam
  2394  Apr 29 23:54:44 candle PAM_pwdb[2285]: (su) session opened for user spam by pavel(uid=0)
  2395  Apr 30 00:00:14 candle sudo:    pavel : TTY=pts/0 ; PWD=/home/pavel ; USER=root ; COMMAND=/bin/su -
  2396  Apr 30 00:00:14 candle PAM_pwdb[2320]: (su) session opened for user root by pavel(uid=0)
  2397  Apr 30 00:01:00 candle kernel: vs-13048: reiserfs_iget: bad_inode. Stat data of (7772 8013) not found 
