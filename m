Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266718AbSLWItz>; Mon, 23 Dec 2002 03:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266720AbSLWItz>; Mon, 23 Dec 2002 03:49:55 -0500
Received: from sabre.velocet.net ([216.138.209.205]:13587 "HELO
	sabre.velocet.net") by vger.kernel.org with SMTP id <S266718AbSLWIty>;
	Mon, 23 Dec 2002 03:49:54 -0500
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Greg Stark <gsstark@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: More tests [Was: Problem with read blocking for a long time on /dev/scd1]
References: <87adj0b3hj.fsf@stark.dyndns.tv> <87u1h799v5.fsf@stark.dyndns.tv>
	<87of7euj51.fsf_-_@stark.dyndns.tv>
	<20021222201345.GG30634@unthought.net>
In-Reply-To: <20021222201345.GG30634@unthought.net>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 23 Dec 2002 03:58:02 -0500
Message-ID: <87n0mxt8md.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Oestergaard <jakob@unthought.net> writes:

> On Sun, Dec 22, 2002 at 11:13:14AM -0500, Greg Stark wrote:
> > 
> > I've done some more tests:
> > 
> > The problem still occurs with straight ide drivers, no ide-scsi
> > 
> > The problem still occurs with 2.4.20-ac2
> 
> Can you reproduce on 2.4.18 or 2.4.19-pre5 ?
> 
> AFAIK 2.4.X broke at 2.4.19-pre6 - something was changed that related to
> the order in which read requests are scheduled.

I originally had the problem with 2.4.18 and only updated to 2.4.20-ac2 hoping
it would solve the problem. It doesn't look like the same issue as yours.

When your process is blocked, what wait channel does ps -elf list for it?
What system call does strace -T show it executing and for how long?

I wonder what else is on the ide channels, perhaps if I move things around so
it's the only device on that channel it would help?

-- 
greg

