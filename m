Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280669AbRKFWyJ>; Tue, 6 Nov 2001 17:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280665AbRKFWxz>; Tue, 6 Nov 2001 17:53:55 -0500
Received: from ldap.austria.eu.net ([193.81.83.3]:36037 "EHLO
	hausmasta.austria.eu.net") by vger.kernel.org with ESMTP
	id <S280656AbRKFWvy>; Tue, 6 Nov 2001 17:51:54 -0500
Message-ID: <3BE86986.F975DEB9@eunet.at>
Date: Tue, 06 Nov 2001 23:51:50 +0100
From: Michael Reinelt <reinelt@eunet.at>
Organization: netWorks
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: modules load, but do not initialize
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.10.0.21)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found a strange behaviour today: I'm experimenting with a boot floppy
with its own little linux on it, based on kernel 2.4.14. 

I get the same effects when I really boot the disk, or if I chroot()
into the directory which will later get imaged to disk: I can load and
unload modules (with insmod, lsmod, rmmod, modprobe), but it looks like
they never get initialised. I know for shure that some modules should
write something to syslog or the console, delay a bit (esp
ide-probe-mod), and, last but not least, provide a device or something.
Nothing of this happens.

Well, something happens after a few tries: it ooopses...

What's happening here?

I can provide any info you like or need. 


bye, Michael

-- 
netWorks                                          Vox: +43 316  698260
Michael Reinelt                                   Fax: +43 316  692343
Geisslergasse 4                                   GSM: +43 676 3079941
A-8045 Graz, Austria                          e-mail: reinelt@eunet.at
