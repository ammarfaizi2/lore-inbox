Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265417AbTGCWPp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 18:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265426AbTGCWPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 18:15:45 -0400
Received: from mailadmin.live365.com ([216.235.80.39]:45326 "EHLO
	mailadmin.live365.com") by vger.kernel.org with ESMTP
	id S265417AbTGCWPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 18:15:43 -0400
Message-ID: <3F04AE65.1000604@nospam.com>
Date: Thu, 03 Jul 2003 15:29:57 -0700
From: "John E. Leon Guerrero" <jguerrero-useatsign-live365.com@nospam.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roberto Slepetys Ferreira <slepetys@homeworks.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM:  2.4.20 os hang when accessing local ide harddrive
References: <3EDFDDBA.2060706@live365.com> <3F0475F7.1070208@nospam.com> <018901c3419a$69efd440$3300a8c0@Slepetys>
In-Reply-To: <018901c3419a$69efd440$3300a8c0@Slepetys>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roberto,

Here is more information from a test i did a minute ago:
1. i just started the machine, mounted a directory from another system 
which has a very large tar file, and then i untarred it to the ide drive 
mounted on the scsi root drive.  this was done on the first console screen.
2. after a couple of minutes, the untar stops writing to the screen.  i 
notice that the case-hard-drive-light is stuck on.
3. i was tailing /var/log/message in another window over ssh from 
another machine.  nothing happened in that screen.  i exited the tail 
and checked if anything was written to syslog.  notice that at this 
point, i think the ide harddrive is frozen yet i am still able to run 
commands like i would expect.
4. on the console, i log in on the 2nd console screen and try to startx. 
  this hangs and does not respond to control-c.
5. in my ssh window, i try df -k.  now, this hangs and ignores control-c.
6. i try to start another ssh window...this no longer works and just hangs.
7. at this point, i reboot the machine.

on a related note, i have yet a 3rd machine to experience this type of 
hang just this morning.  it is running the exact same kernel from the 
first machine...compiled from the 2.4.20 sources.  in this scenario:
1. i was running xmms and listening to internet radio (live365 of course :)
2. in a ssh window, i changed directories to an ide drive (mounted on 
another ide drive this time.)
3. i tried to lists the contents of a file and noticed that it hung.  at 
that point, i noticed that x windows was frozen and the sound was 
looping.  i didn't have my head phones on at the time the problem 
started so unfortunately, i cannot positively say that listing the file 
caused the entire system to hang but that is my gut feel.
4. this system had been up for weeks.  the root file system was 
definitely active in that time frame, but the mounted ide drive was idle 
  for at least a week before i tried to access that file.  also, i saw 
that the case-hard-drive-light was stuck on just like in the first 
problem that i reported.
5. i checked and there was nothing in messages nor syslog at the time of 
the hang.

if it is related, the other machine that hung happened after mounting 
and unmounting some floppies.  that was also on 2.4.20, debian 
woody...but built separately from the other 2 machines.

jlg

Roberto Slepetys Ferreira wrote:

> Hi Guerrero,
> 
> I am having some hangs with the 2.4.20 kernel without isolatting the source
> of the trouble.
> 
> Is there any strange message at /var/log/message ? How do you concluded that
> is the IDE drive ?
> 
> In my linux box, it halts without any clue of what is going on. First I
> thank that the trouble was with AIC7xxx and SCSI drives, because of a
> correlation of large I/O and linux halt, but after a big help from Justin
> Gibbs, when I upgraded the AICxxx module to the newer, the system hangs
> without the old message: Locking max tag count...
> 
> []s
> Slepetys
> 
> 


