Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312446AbSDNTht>; Sun, 14 Apr 2002 15:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312447AbSDNThs>; Sun, 14 Apr 2002 15:37:48 -0400
Received: from brussels-smtp.planetinternet.be ([195.95.34.12]:27402 "EHLO
	firebird.planetinternet.be") by vger.kernel.org with ESMTP
	id <S312446AbSDNThr>; Sun, 14 Apr 2002 15:37:47 -0400
Date: Sun, 14 Apr 2002 21:38:13 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.5.8 pre3 chown problem
Message-ID: <20020414193813.GA668@gouv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Leopold Gouverneur <lgouv@planetinternet.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried 2.5.8 pre3 and exim stopped working!
I found the problem was that logrotate is unable to change
exim's mainlog owner from root to mail. So i made a little test:

gouv:~# touch junk
gouv:~# ls -l junk
-rw-r--r--    1 root     root            0 avr 14 21:30 junk
gouv:~# chown mail.adm junk
gouv:~# echo $?
0
gouv:~# ls -l junk
-rw-r--r--    1 root     adm             0 avr 14 21:30 junk

gouv:~# chown --version
chown (fileutils) 4.1
Écrit par David MacKenzie.

gouv:~# bash --version 
GNU bash, version 2.05a.0(1)-release (i386-pc-linux-gnu)
Copyright 2001 Free Software Foundation, Inc.

file system is ext 2

I reverted to 2.5.7 and everyting worked as expected


