Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131059AbRBQTW7>; Sat, 17 Feb 2001 14:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130902AbRBQTWs>; Sat, 17 Feb 2001 14:22:48 -0500
Received: from web1304.mail.yahoo.com ([128.11.23.154]:22541 "HELO
	web1304.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130520AbRBQTWk>; Sat, 17 Feb 2001 14:22:40 -0500
Message-ID: <20010217192238.28676.qmail@web1304.mail.yahoo.com>
Date: Sat, 17 Feb 2001 11:22:38 -0800 (PST)
From: Mark Swanson <swansma@yahoo.com>
Subject: Re: System V msg queue bugs in latest kernels
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A8ECB1B.776D0372@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are right.
/proc/sysvipc/msg is correct. It shows:
cbytes: 1048575
qnum: 95325

ipcs shows:
used-bytes: 65535
messages: 65535

It's a 16-bit number issue.

--- Manfred Spraul <manfred@colorfullife.com> wrote:
> Mark Swanson wrote:
> > 
> > Hello,
> > 
> > ipcs (msg) gives incorrect results if used-bytes is above 65536. It
> > stays at 65536 even though messages are being read and removed from
> the
> > msg queue.
> >
> I'm testing it.
> 
> Could you check /proc/sysvipc/msg?
> 
> I know that several API's have 16-bit numbers, perhaps wrong values
> are
> returned to user space.
> 
> --
> 	Manfred


=====
A camel is ugly but useful; it may stink, and it may spit, but it'll get you where you're going. - Larry Wall -

__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail - only $35 
a year!  http://personal.mail.yahoo.com/
