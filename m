Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261653AbTCaO3v>; Mon, 31 Mar 2003 09:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261659AbTCaO3v>; Mon, 31 Mar 2003 09:29:51 -0500
Received: from web20003.mail.yahoo.com ([216.136.225.48]:27967 "HELO
	web20003.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261653AbTCaO3u>; Mon, 31 Mar 2003 09:29:50 -0500
Message-ID: <20030331144110.55232.qmail@web20003.mail.yahoo.com>
Date: Mon, 31 Mar 2003 06:41:10 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: mmap-related questions
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!  I hate to ask this type of questions here,
but having searched the list and googling, I have
found no good answers, so here goes..

If I use mmap to give me a sliding window view onto a
file (mmap/munmap/mmap or mremap), how can I sync all
unmapped memory associated with the file?

I read from Stevens that "the call to munmap does not
cause the contents of the mapped region to be written
to the disk file.", but I don't want to pay the
penalty of doing many msync()'s each time I move my
window.
I tested that fsync() does not seem to sync pages that
were mapped with mmap.  Is there some way to sync all
data associated with the file?  Is there a way which
is also portable to Solaris 2.6?

Thanks,
-Kenny

BTW: I'm using 2.4.7 (RH enterprise)


__________________________________________________
Do you Yahoo!?
Yahoo! Platinum - Watch CBS' NCAA March Madness, live on your desktop!
http://platinum.yahoo.com
