Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314592AbSD0FEv>; Sat, 27 Apr 2002 01:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314596AbSD0FEv>; Sat, 27 Apr 2002 01:04:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:54779 "EHLO
	VL-MS-MR005.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S314592AbSD0FEu>; Sat, 27 Apr 2002 01:04:50 -0400
From: "Enrico Demarin" <enricod@videotron.ca>
To: "'Richard Thrapp'" <rthrapp@sbcglobal.net>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: The tainted message
Date: Sat, 27 Apr 2002 01:06:07 -0700
Message-ID: <00b201c1edc2$62c8f520$0340a8c0@shodan2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <1019883102.8819.48.camel@wizard>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well a smart user could eliminate the tainted stuff and get support
anyway. 

What's the point of having such a message ? I think it's trivial to get
rid of it anyway.

- Enrico 

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Richard Thrapp
Sent: April 26, 2002 9:52 PM
To: linux-kernel; alan@lxorguk.ukuu.org.uk
Subject: The tainted message


I originally took this up with Keith Owens, but he said I should bring
the discussion here since the message was chosen here (although I  could
not find where in the archives), and that he might change it if I get
the approval of Alan Cox.

I just discovered semi-recently (a couple of months ago) that newer
versions of modutils have an insmod that prints out the tainted warnings
for non-GPL licenses.  While I agree that printing a warning when
installing a non-GPLed module is important to inform the user that their
kernel is no longer supported by the kernel maintainers, I have issues
with the exact message printed.

First of all, the current tainted message is not really useful. 
"Warning: Loading %s will taint the kernel..." isn't very informative at
all.  Most people don't know what it means to "taint the  kernel".  It's
a vague phrase in English, and only if you know the current kernel
source (or at least some of the semi-recent discussions on kernel
tainting) is its meaning clear.  As a matter of fact, it makes it sound
like the module has a virus in it that has just infected your kernel. 
As Linux becomes more common for non-experts, it becomes even more
important for error and informational messages to be clear.

Secondly, loading the module doesn't actually 'taint' the kernel, but
instead it mostly invalidates your chances for support from the core
kernel maintainers.

Thirdly, the warning that loading the module "will" taint the kernel is
an inaccurate use of tense.  It implies that the module wasn't loaded
(which might be true at that time from the point of view of the code,
but is not true from the point of view of the user, which is who the
message is written for).  I have actually had bug reports where users
complain that a module won't load because of the tense of this message.

I would like to propose that a clearer, more direct message be used. 
Something like "Warning: kernel maintainers may not support your kernel
since you have loaded %s: %s%s\n" would be much more informative and
correct.

Opinions?  Comments?

Thanks!

-- Richard Thrapp


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

