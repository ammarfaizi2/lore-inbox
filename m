Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132399AbRDCSF7>; Tue, 3 Apr 2001 14:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132400AbRDCSFt>; Tue, 3 Apr 2001 14:05:49 -0400
Received: from raven.toyota.com ([63.87.74.200]:63749 "EHLO raven.toyota.com")
	by vger.kernel.org with ESMTP id <S132399AbRDCSFi>;
	Tue, 3 Apr 2001 14:05:38 -0400
Message-ID: <3ACA10C7.FB117A53@lexus.com>
Date: Tue, 03 Apr 2001 11:04:56 -0700
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Trevor Nichols <ocdi@ocdi.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: uninteruptable sleep
In-Reply-To: <Pine.BSF.4.33.0104040122330.63187-100000@ocdi.sb101.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trevor Nichols wrote:

> > Its a kernel bug if it gets stuck like this. You need to provide more info
> > though - what file system, what devices, how much memory. Also ps can give you
> > the wait address of a process stuck in 'D' state which is valuable for debug
>
> ps xl:
>   F   UID   PID  PPID PRI  NI   VSZ  RSS WCHAN  STAT TTY        TIME  COMMAND
> 040  1000  1230     1   9   0 24320    4 down_w D    ?          0:00  /home/data/mozilla/obj/dist/bin/mozi
>
> [I'm not exactly sure how to get the wait address if it isn't shown above]
>

Try this:

ps -eo pid,stat,pcpu,nwchan,wchan=WIDE-WCHAN-COLUMN -o args


cu

Jup

