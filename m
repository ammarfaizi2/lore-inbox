Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261682AbRE3ROH>; Wed, 30 May 2001 13:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261696AbRE3RN5>; Wed, 30 May 2001 13:13:57 -0400
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:50447 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id <S261682AbRE3RNs>; Wed, 30 May 2001 13:13:48 -0400
Date: Wed, 30 May 2001 19:13:37 +0200 (CEST)
From: "Rasmus B. Hansen" <moffe@amagerkollegiet.dk>
To: Edsel Adap <edsel@adap.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ln -s broken on 2.4.5
In-Reply-To: <20010530124052.A26266@adap.org>
Message-ID: <Pine.BSO.4.33.0105301911200.28371-100000@smaug.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Edsel Adap wrote:

> I downloaded the linux 2.4.5 sources and built and installed them on my
> system.  Since then, I've noticed strange file system behavior:

> marvin:/tmp> ln -s foo bar

> lrwxrwxrwx    1 adap     users           3 May 30 12:09 bar -> bar

> Notice that the symlink created is wrong.  It seems that any symlink I
> create is always linked to itself.

I tried the same:

moffe@grignard:/tmp/test# ls -la
totalt 1
drwxr-xr-x    2 moffe    users          48 ons maj 30 19:10:20 2001 .
drwxrwxrwt   13 root     root          496 ons maj 30 19:10:40 2001 ..
moffe@grignard:/tmp/test# ln -s foo bar
moffe@grignard:/tmp/test# ls -la
totalt 1
drwxr-xr-x    2 moffe    users          72 ons maj 30 19:10:58 2001 .
drwxrwxrwt   13 root     root          496 ons maj 30 19:10:40 2001 ..
lrwxrwxrwx    1 moffe    users           3 ons maj 30 19:10:58 2001 bar -> foo
moffe@grignard:/tmp/test# cd /boot/test/
moffe@grignard:/boot/test# ls -la
totalt 2
drwxr-xr-x    2 moffe    users        1024 ons maj 30 19:10:28 2001 .
drwxr-xr-x    4 root     root         1024 ons maj 30 19:10:28 2001 ..
moffe@grignard:/boot/test# ln -s foo bar
moffe@grignard:/boot/test# ls -la
totalt 2
drwxr-xr-x    2 moffe    users        1024 ons maj 30 19:11:09 2001 .
drwxr-xr-x    4 root     root         1024 ons maj 30 19:10:28 2001 ..
lrwxrwxrwx    1 moffe    users           3 ons maj 30 19:11:09 2001 bar -> foo

/ is on reiserfs and /boot is on ext2 - as you see, I do not have the
problem (also running 2.4.5).

Could it be a fileutils problem?

Rasmus

-- 
-- [ Rasmus 'Møffe' Bøg Hansen ] --------------------------------------
Programming is a race between programmers, who try and make more and
more idiot-proof software, and universe, which produces more and more
remarkable idiots.
Until now, universe leads the race.
                                                           - R. Cooka
-------------------------------- [ moffe at amagerkollegiet dot dk ] --

