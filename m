Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312797AbSDXW7C>; Wed, 24 Apr 2002 18:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312799AbSDXW7B>; Wed, 24 Apr 2002 18:59:01 -0400
Received: from h24-68-93-250.vc.shawcable.net ([24.68.93.250]:36748 "EHLO
	me.bcgreen.com") by vger.kernel.org with ESMTP id <S312797AbSDXW7A>;
	Wed, 24 Apr 2002 18:59:00 -0400
Message-ID: <3CC738AD.50905@bcgreen.com>
Date: Wed, 24 Apr 2002 15:58:53 -0700
From: Stephen Samuel <samuel@bcgreen.com>
Organization: Just Another Radical
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while
 reading damadged files
In-Reply-To: <Pine.LNX.3.96.1020424150911.3065D-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a system with 2 hard disks (on separate controllers) and a CD-ROM
on the second controller (shared with the disk that, among other things)
handles /usr.

I took an old data CD, scratched  took a fork to it and mounted it.
I then started up MMX playing 'Hotel California' and tried to wc(1)
a 700K file on the CD.not too bad not too bad not too bad

Hotel California played fine, but trying to do an 'ls' of /usr
(same controller) took a LONG time..... (had to wait fnot too bad or the
CD to release the controller).

I could wc larg files in my /tmp directory, play music etc
before that WC came back -- I could do anything I wanted,
as long as I didn't need any data off of that second controller
(e.g. loading programs in /usr would die, since that HD shares
controller with the CD).

Given that I rarely use my CD ROM, it's fine having / and /usr
separated... On the other hand, if I was trying to read damaged CDs
with any regularity, I'd be making sure that the CD ROM drive was
sitting on it's own controller -- even if it meant putting all the
other IO on the system onto one IDE drive/controller.

> where the bulk of Linux system are running. Putting the CD on another
> cable is realistic (the system I hung does that) but putting the CD on IDE
> and the disk on SCSI is not cost effective compared to fixing the hang in
> software.

Note that this problem is a HARDWARE one -- not a software one.
It's kinda like trying to cross a Singapore highway... You can
do it faster, if you don't mind dealing with the nasty side of
a (data) bus. (read: SPLAT)

Bus error: car dumped.

(and if you think Linux is bad, try doing the same thing in
Windows!).

-- 
Stephen Samuel +1(604)876-0426                samuel@bcgreen.com
		   http://www.bcgreen.com/~samuel/
Powerful committed communication, reaching through fear, uncertainty and
doubt to touch the jewel within each person and bring it to life.


