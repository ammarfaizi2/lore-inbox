Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281239AbRK0Prt>; Tue, 27 Nov 2001 10:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281009AbRK0Prk>; Tue, 27 Nov 2001 10:47:40 -0500
Received: from [195.66.192.167] ([195.66.192.167]:37132 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S280817AbRK0Prf>; Tue, 27 Nov 2001 10:47:35 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] printk loglevel cleanup (again)
Date: Tue, 27 Nov 2001 17:43:30 -0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01112717433007.00872@manta>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since we are past 2.5.0 point, I hope this patch have better chances,
at least for 2.5.x :-)

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
and apply the rest - all these changes are independent
of each other, you may even just ignore rejects
if you are patching newer/older kernel!

If you like this patch but have more interesting things to play with,
you may do the following:
* clear your logs
* reconfigure syslogd to spew warnings to /var/log/syslog.warnings
* reboot
* mail boot time "warnings" which you think are not warnings but
info only ("104-key keyboard detected"-type msgs) to me -
I'll add fixes for those to this patch

Go to: http://port.imtp.ilyichevsk.odessa.ua/linux/vda/
--
vda
