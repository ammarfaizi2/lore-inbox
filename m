Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268764AbTBZOy6>; Wed, 26 Feb 2003 09:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268765AbTBZOy6>; Wed, 26 Feb 2003 09:54:58 -0500
Received: from h108-129-61.datawire.net ([207.61.129.108]:21691 "EHLO
	mail.datawire.net") by vger.kernel.org with ESMTP
	id <S268764AbTBZOy5>; Wed, 26 Feb 2003 09:54:57 -0500
From: Shawn Starr <shawn.starr@datawire.net>
Organization: Datawire Communication Networks Inc.
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG][2.5.63] New IDE changes cause data corruption on PIIX4 AND additional problems
Date: Wed, 26 Feb 2003 10:10:20 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302261010.20360.shawn.starr@datawire.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Booting 2.5.63 I ran into several problems:

1. With full kernel debugging on, sleeping contexts loop forever, Adam Belay 
has a fix that worked for me - Still testing

2. When booting over serial console if i get a buffer overrun error, I loose 
total access to the machine. I can't ssh in or use direct console. This did 
not happen in .62.

3. Data corruption with PIIX4:  While vi'ing /etc/lilo.conf exiting, then 
vi'ing /etc/inittab saving a change. I ran init q. The moment I ran it i got 
a strange panic from bash and a *__timers function. When I rebooted inittab 
was corrupt and oddly /etc/inittab became lilo.conf! (it had the same 
contents, acrossed inode somehow?).

/me looks at Alan with evil eyes IDE was working so well ;-(

-- 
Shawn Starr
UNIX Systems Administrator, Operations
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416-213-2001 ext 179  F: 416-213-2008
shawn.starr@datawire.net
"The power to Transact" - http://www.datawire.net

