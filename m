Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269632AbRHHXYy>; Wed, 8 Aug 2001 19:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269633AbRHHXYp>; Wed, 8 Aug 2001 19:24:45 -0400
Received: from smtp1.legato.com ([137.69.200.1]:62198 "EHLO smtp1.legato.com")
	by vger.kernel.org with ESMTP id <S269632AbRHHXY2>;
	Wed, 8 Aug 2001 19:24:28 -0400
Message-ID: <00a201c12061$52dc7260$5c044589@legato.com>
From: "David E. Weekly" <dweekly@legato.com>
To: "ML-linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Efficient Event Handling In Linux?
Date: Wed, 8 Aug 2001 16:24:51 -0700
Organization: Legato Systems, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all. I've been looking at efficient event-handling mechanisms (for I/O
on sockets, disk, devices) on various operating systems; poking through the
list archives reveals some excellent, juicy discussions that flared up
around late October, with Linus strongly in favor of a new
"get_events/bind_event()" style, some parties in favor of a FreeBSD kqueue
style, and some fans of Solaris 8's /dev/poll flavor.

As far as I could tell (and my most humble of apologies if this is not the
case), the discussion trailed off without any real resolution as to what
would actually be done to empower Linux with efficient event handling;
perhaps I missed it, but I couldn't find Linus's get_events/bind_event
calls, nor could I find /dev/poll or kqueue-styled interfaces integrated
into the latest kernel.

I did find what looks to be an excellent patch in the way of /dev/epoll
(written up here:
http://www.xmailserver.org/linux-patches/nio-improve.html). According to the
benchmarks he's got, the patch really spanks /dev/poll and POSIX SIGIO. I'm
going to begin testing with it soon and was hoping to get some feel for
whether /dev/epoll might end up in the kernel mainstream at some point in
the not-too-distant future? If not, what? It seems a shame for Linux to be
somewhat behind Solaris (/dev/poll), FreeBSD (kqueue), and Windows2000
(Completion Ports) in performance; it would be fabulous to see formal
acceptance of /dev/epoll or something equivalent.

Is Linux really not that far behind performance-wise (i.e., most of these
benchmarks are misleading)? Have there already been good performance patches
in this style? Please fill me in, though I've got a feeling I'm not the only
one a little clueless on what the current state of affairs is in this
department. =)


 -david


[reference: Linus's suggestion for get_events/bind_event()]
http://uwsg.iu.edu/hypermail/linux/kernel/0010.3/0003.html


