Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293365AbSBYJo4>; Mon, 25 Feb 2002 04:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293366AbSBYJop>; Mon, 25 Feb 2002 04:44:45 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:21522 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S293365AbSBYJog>; Mon, 25 Feb 2002 04:44:36 -0500
Message-ID: <3C7A073D.90A33D03@aitel.hist.no>
Date: Mon, 25 Feb 2002 10:43:25 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.4-dj1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: David Burrows <snadge@ugh.net.au>, linux-kernel@vger.kernel.org
Subject: Re: Dodgey Linus BogoMIPS code ;) (was Re: baffling linux bug)
In-Reply-To: <20020222122108.I15623-100000@starbug.ugh.net.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Burrows wrote:
> 
> On Thu, 21 Feb 2002, Mike Fedyk wrote:
> > I didn't see one thing mentioning Linus in there... ;)  I could sue if you
> > were selling something. ;)
> 
> Kind of.  Except Linus wrote the particular section of code in question.
> =)
> 
> > Anyway, jiffies are same as HZ and on i386 100 jiffies/sec, and one timer
> > interrupt per jiffie.
> 
> Or perhaps not in the case of my hardware functioning properly one day,
> and never to boot linux (but fine with everything else) again..
> 
> I need a sure fire way of testing whether the timer interrupt works,

I once used a printk in the keyboard irq handler to check a 
nonstandard keyboard.  You may put a printk() in the timer interrupt
handler.  
That should show that the irq handler works.  Of course you don't want
to
run such a log-filler for long... :-)

Maybe you can get the machine to boot by skipping the bogomips
calculation completely - by hardcoding the value your machine used to 
come up with?
Not for production use - just to get a debugging kernel going.

Helge Hafting
