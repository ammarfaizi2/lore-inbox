Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282963AbRLQWRi>; Mon, 17 Dec 2001 17:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282962AbRLQWRR>; Mon, 17 Dec 2001 17:17:17 -0500
Received: from erasmus.jurri.net ([62.236.96.196]:18917 "EHLO
	oberon.erasmus.jurri.net") by vger.kernel.org with ESMTP
	id <S282947AbRLQWRG>; Mon, 17 Dec 2001 17:17:06 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.16: Out of memory - when still more than 100MB free
From: Samuli Suonpaa <suonpaa@iki.fi>
Date: 17 Dec 2001 23:44:28 +0200
Message-ID: <87elltwmgz.fsf@puck.erasmus.jurri.net>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got VMWare killed a couple of times mysteriously. 

I've got 256MB memory and no swap on my laptop running 2.4.16 and for
some reason VMWare has got killed with the following syslog
information:

Dec 17 23:33:23 puck kernel: Out of Memory: Killed process 28803 (vmware).
Dec 17 23:33:35 puck kernel: Out of Memory: Killed process 28804 (vmware).
Dec 17 23:33:37 puck kernel: /dev/vmmon: Vmx86_ReleaseVM: unlocked pages: 75286, unlocked dirty pages: 51084

What I find odd is, that I am quite certain this machine did _not_ run
out of memory when this happened. Just a few minutes ago I had an idle
VMWare session and started an XEmacs to edit a large file. Just being
curious, I happened to say 'free' a few seconds before VMWare got
killed:

$ free
             total       used       free     shared    buffers     cached
Mem:        256224     219748      36476          0      12956      48816
-/+ buffers/cache:     157976      98248
Swap:            0          0          0

Boom, it died about the same time I exit from XEmacs. After that, I
ran 'free' again:

n$ free
             total       used       free     shared    buffers     cached
Mem:        256224     203644      52580          0      13148      81620
-/+ buffers/cache:     108876     147348
Swap:            0          0          0

I may be missing something obvious herfe, but I just can't figure out
why kernel killes VMWare in this situation.

If anyone's interested, I think I can reproduce this and - if someone
will kindly instruct me a bit - produce some more information. I
_think_ this is the place where experienced kernel hackers start
speaking about running 'vmstat'. And where I usually start having
problems undertanding what it is that people are talking about...

Suonp‰‰...
