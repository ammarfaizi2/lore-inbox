Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRCAGNf>; Thu, 1 Mar 2001 01:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129525AbRCAGNZ>; Thu, 1 Mar 2001 01:13:25 -0500
Received: from mailhost01.reflexnet.net ([64.6.192.82]:1037 "EHLO
	mailhost01.reflexnet.net") by vger.kernel.org with ESMTP
	id <S129511AbRCAGNK>; Thu, 1 Mar 2001 01:13:10 -0500
From: "Balbir Singh" <balbir@reflexnet.net>
To: "Vibol Hou" <vhou@khmer.cc>, "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: RE: Sytem slowdown on 2.4.1-ac20 (recurring from 2.4.0)
Date: Wed, 28 Feb 2001 22:15:42 -0800
Message-ID: <BGEJLPPGOHFHAKLMHGBJAEEFCAAA.balbir@reflexnet.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <NDBBKKONDOBLNCIOPCGHCEOGEPAA.vhou@khmer.cc>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI:

I remember posting something a few days ago to make the serial console more
reliable for such situations. Some allocations in the serial port driver are
done at runtime using page_alloc, if somebody runs out of memory the serial
tty driver would not work properly.

I am not saying that u ran out of memory. All I am saying is that it is
possible to make the serial tty driver more reliable using boot time
initialization.

Please excuse me if u find this a little off-topic.



-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Vibol Hou
Sent: Monday, February 26, 2001 4:25 PM
To: Linux-Kernel
Subject: Sytem slowdown on 2.4.1-ac20 (recurring from 2.4.0)


I've reported this problem a long while ago, but no one answered my pleas.
To tell you the honest truth, I don't know where to begin looking.  It's
difficult to poke around when the serial console is unresponsive :/

When I was running 2.4.0, the system, a dual-processor webserver, would
_completely_ slow down after about 3 days of constant uptime (and a few
million pages served).  I mean _SLOW_.  I could get commands executed, but
it would take an unholy long time to type the commands in.  It seemed the
server was dropping lots of packets.  All TCP services simply stopped or
slowed.  ICMP packet loss to the server would be a sporadic from 50% to 75%.
Web service was rendered useless.  SSH _barely_ worked.  The number of
commands I could run (w, free, memstat, top) showed nothing out of the
ordinary.  Back then, I didn't have a serial console setup.

Now, I'm running 2.4.1-ac20 and I setup a serial console to try to catch any
errors.  I was hoping the problem wouldn't recur with this newer kernel, but
it seems to still happen, but now at about 5 days uptime.  When I manage to
get in a 'shutdown -h now' through SSH, the serial console spits out:

INIT: Switching to runlevel: 0
INIT:

And that's it.  It doesn't even seem to be able to finish shutting down.
Thusfar, no one else has reported any similar problems to what I have, so it
makes me wonder what is wrong.  The system ran fine with an uptime of over
100 days with the old 2.2.17 kernel.  What stifles me is the fact that the
serial console is completely unresponsive to input when the server gets into
this state.

Having said that, does anyone have any ideas or pointers for me?  Again,
this may seem like a fairly indescriptive e-mail, but that's just because I
can't do anything on the server when it gets to this state.  If there is
anything you recommend I do when this happens again (other than restart the
system), please let me know and I'll try.

--
Vibol Hou
KhmerConnection, http://khmer.cc

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

