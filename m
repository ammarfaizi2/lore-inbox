Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTDDUb5 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 15:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbTDDUb5 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 15:31:57 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:60820 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261352AbTDDUby (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 15:31:54 -0500
Subject: ext3 and filename globbing with ext3
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1049489004.1213.18.camel@aurora.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 04 Apr 2003 15:43:24 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux aurora.localdomain 2.4.20-2.48 #1 Thu Feb 13 11:52:40 EST 2003
i686 athlon i386 GNU/Linux

$ rpm -qa | grep openssh
openssh-askpass-gnome-3.5p1-6
openssh-3.5p1-6
openssh-server-3.5p1-6
openssh-askpass-3.5p1-6
openssh-clients-3.5p1-6

Okay, here we go.  Earlier today, I erased several images from my local
working directory for a website.  I updated several other things and
then ran the following:

scp -r pics user@site:/home/trever/somewebsite/

speachbubbleLONG.jpg 100% |*****************************|  2868      
00:00
speachbubble.jpg     100% |*****************************|  3428      
00:00
speechLONG-L.jpg     100% |*****************************|  2868      
00:00
speechLONG-R.jpg     100% |*****************************|  2868      
00:00
speech-L.jpg         100% |*****************************|  3428      
00:00
speech-R.jpg         100% |*****************************|  3428      
00:00
speechLONG-L.jpg     100% |*****************************|  4751      
00:00

The speachbubble* were among the files I had erased about at least 15
minutes before hand (maybe over an hour).

This happened every time I used the command.  However when I changed
into the pics directory and ran:

scp  * user@site:/home/trever/somewebsite/pics/

It didn't copy those files, didn't even see them.  An ls doesn't show
them either.

I have seen this happen several times before, I just realized for once
it is indeed a bug and not me messing up or imagining things.

My filesystem is mounted as ordered mode w/ ext3.  Is this a known bug?

Trever Adams
--
One O.S. to rule them all, One O.S. to find them. One O.S. to bring them
all and in the darkness bind them.

