Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280133AbRKIVVf>; Fri, 9 Nov 2001 16:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280134AbRKIVVV>; Fri, 9 Nov 2001 16:21:21 -0500
Received: from [195.66.192.167] ([195.66.192.167]:13075 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S280133AbRKIVVE>; Fri, 9 Nov 2001 16:21:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Robert Love <rml@tech9.net>
Subject: Re: [PATCH] Adding KERN_INFO to some printks #2
Date: Fri, 9 Nov 2001 23:20:47 +0000
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <01110913474600.02130@nemo> <1005321383.1209.8.camel@phantasy>
In-Reply-To: <1005321383.1209.8.camel@phantasy>
MIME-Version: 1.0
Message-Id: <01110923204702.00807@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 November 2001 15:56, Robert Love wrote:
> On Fri, 2001-11-09 at 08:47, vda wrote:
> > Primary purpose of this patch is to make KERN_WARNING and...
>
> This is an _excellent_ patch and you should proffer it to Linus and Alan
> when you are done.  I would recommend diffing off 2.4.14 instead of
> 2.4.13, to this end.
>
> I haven't gone over the actual loglevel warnings, but I plan to.  A
> quick glimpse shows you are changing what needs to be changed.  Good
> job.

Well... thanks man.
I hope patch will be noticed by our tribal leaders :-)
(Linus? Alan?)

Rediffed patch against 2.4.15-pre1 can be found at 
http://port.imtp.ilyichevsk.odessa.ua/linux/vda/KERN_INFO-2.4.15-pre1.diff

or emailed on request (our www server isn't exactly powerful, you may
have difficulty downloading the patch)
--------
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
I'll add fixes for those msgs to this patch
--
vda
