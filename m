Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318428AbSIBT5h>; Mon, 2 Sep 2002 15:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318435AbSIBT5h>; Mon, 2 Sep 2002 15:57:37 -0400
Received: from mx6.mail.ru ([194.67.57.16]:3601 "EHLO mx6.mail.ru")
	by vger.kernel.org with ESMTP id <S318428AbSIBT5g>;
	Mon, 2 Sep 2002 15:57:36 -0400
Date: Tue, 3 Sep 2002 00:00:32 +0400
From: Molbo <molbo@inbox.ru>
X-Mailer: The Bat! (v1.53) UNREG / CD5BF9353B3B7091
Reply-To: Molbo <molbo@inbox.ru>
X-Priority: 3 (Normal)
Message-ID: <1173317726.20020903000032@inbox.ru>
To: linux-kernel@vger.kernel.org
Subject: may be new filesystem module?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

F.P.
  sorry for this long and may be OT post


hd partitions is a hardware bug
LVM is a thing that is a level higher that hd partitions


can some body point my to souch thing:
  it must be mountable with mount, and must connect mounted
  filesystem according some rules in to one filesystem(mount point)
  (like lvm combines hd partions in one and splits by rules
     sorry if I'm not so correct as is it, am'not familiar with lvm)
  as example1: I have hda1 hda2 and mount them to /mnt/hda1 with ext2
  and /mnt/hda2 with umsdos, first and second mount points are normal
  capable dirs, and I wona have all this space in one place as /mnt/one
  simple combine two dirs in one, how share dirs and files between
  is a rule task

  second example(that actualy is my interest) is:
    if I have mounted in prev example /mnt/hda1 as read only
    and /mnt/hda2 as rw then I combine two dirs in one
    /mnt/one
    simple rule for this case may be if opens /mnt/one/somefile
    first search it as /mnt/hda2/somefile if not found
    in /mnt/hda1/somefile
    second rule is that when try to write to /mnt/one/somefile
    and it is open from /mnt/hda1 (that ro is) make a copy
    of this file on /mnt/hda2/somefile, open from this location
    and write to it

    this allows to have some data on cd as example and update
    of this data on hd

I know AVFS but it works not as mountable filesystem but as some hack
and to do rule from second example, it must be great work(may be)


--------questions---------
how i can do that i have a lot of files on cd and there modifyed
versions on hdd, and as result I'm using uptodate data
(I think about cd based linux and i know some projects, but it's
 all ~1g to download and have some packages that i won't and not have
 packages that i wona. I can install on hdd packages that i wona
 and burn it on cd, but from beginning i must known what and how
 it must be config'd, and this config must be for all cases
 it is impossible) and it is a way to have small part of data
 on each machine where i'm using cd based linux, with config
 that for this machine actual is
 
 second possibility that i see is to easy to convert every rw
 mountable filesystem to ext2 comparatible, as umsdos do it to
 msdos filesystem

 another possibility is to get for each process and user own view
 of root tree. I see it as usefull, as example each user can
 have own pap and chap secrets in same place /etc/ppp
 
going somewhere a project that have properties that I have tryed to
describe

Or some place where I can found answer to : how to from module
  that is mounted to some mount point get access to file
  from another filesystem (i have looked some kern and modules
  src but ansver to the question is not so clear for my, how make it
  rigth way)(better as working example, or some docs to this topic)


