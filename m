Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279483AbRKILs7>; Fri, 9 Nov 2001 06:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279832AbRKILsu>; Fri, 9 Nov 2001 06:48:50 -0500
Received: from [195.66.192.167] ([195.66.192.167]:43280 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S279483AbRKILsn>; Fri, 9 Nov 2001 06:48:43 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Adding KERN_INFO to some printks #2
Date: Fri, 9 Nov 2001 13:47:46 +0000
X-Mailer: KMail [version 1.2]
Cc: torvalds@transmeta.com
MIME-Version: 1.0
Message-Id: <01110913474600.02130@nemo>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Primary purpose of this patch is to make KERN_WARNING and
KERN_INFO log levels closer to their original meaning.
Today they are quite far from what was intended.
Just look what kernel writes at the WARNING level
each time you boot your box!

When I was making this patch I couldn't resist and fixed
messed up tabs around affected printks, wrapped some
lines longer than 80 columns, fixed some typos.
My formatting preferences:
* log entries are started with capital letters except for
function/modules names in lowercase or acronyms (IDE etc)
* Dot before \n is a waste of space
* colon style: "Foo: blah blan" (not "Foo : blah" or "Foo: Blah")
But I'm not a religious fanatic: it ok to disagree with me :-)
You can see in the patch that I wasn't overly distracted
by this decorative work.

I'm doing my best trying not to break working code.
However, if you feel paranoid today you may remove
any hunk of this patch you may deem suspicious
and apply the rest - all these changes are independent.

If you like this patch but have more interesting things to play with,
you may do the following:
* clear your logs
* reconfigure syslogd to spew warnings to /var/log/syslog.warnings
* reboot
* mail boot time "warnings" which you think are not warnings but
info only ("104-key keyboard detected"-type msgs) to me -
I'll add fixes for those to this patch.

Patch can be found at
http://port.imtp.ilyichevsk.odessa.ua/linux/vda/KERN_INFO-2.4.13.diff

or emailed on request (our www server isn't exactly powerful, you may
have difficulty downloading the patch)
--
vda
