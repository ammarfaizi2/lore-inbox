Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285399AbRLSQ7X>; Wed, 19 Dec 2001 11:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285403AbRLSQ7N>; Wed, 19 Dec 2001 11:59:13 -0500
Received: from [206.98.161.198] ([206.98.161.198]:61707 "EHLO
	bart.learningpatterns.com") by vger.kernel.org with ESMTP
	id <S285399AbRLSQ7C>; Wed, 19 Dec 2001 11:59:02 -0500
Subject: Re: Reiserfs corruption on 2.4.17-rc1!
From: Edward Muller <emuller@learningpatterns.com>
To: Diego Calleja <grundig@teleline.es>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011217024529.E418@diego>
In-Reply-To: <20011217002350.D418@diego>  <20011217024529.E418@diego>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 19 Dec 2001 11:56:31 -0500
Message-Id: <1008780992.8835.2.camel@akira.learningpatterns.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-12-16 at 20:45, Diego Calleja wrote:
[snip]

> As you said, i've tested the drive:
> 
> root@diego:~# badblocks -n -vv /dev/hdc5
> attempt to access beyond end of device
> 16:05: rw=0, want=9671068, limit=9671067
> 967106456/  9671067
> attempt to access beyond end of device
> 16:05: rw=0, want=9671068, limit=9671067
> 9671065
> attempt to access beyond end of device
> 16:05: rw=0, want=9671068, limit=9671067
> 9671066
> done
> Pass completed, 3 bad blocks found.
[snip]

>From an earlier email...
Well, I've run badblocks in 2.4.16
results:


root@diego:~# badblocks -n -vv /dev/hdc5
Initializing random test data
Checking for bad blocks in non-destructive read-write mode
>From block 0 to 9671067
Checking for bad blocks (non-destructive read-write test): done
Pass completed, 0 bad blocks found.
root@diego:~#


So under 2.4.17-rc1 Diego gets the '...access beyond end of device' and
with 2.4.16 he doesn't.

For some reason the badblocks program under 2.4.16 ends at block
9671067, while the 2.4.17-rc1 test tries to go beyond that for some
reason.

Diego, what happens when you run the fsk/try to access /etc/mtab (and
the like) under 2.4.16?


-- 
-------------------------------
Edward Muller
Director of IS

973-715-0230 (cell)
212-487-9064 x115 (NYC)

http://www.learningpatterns.com
-------------------------------

