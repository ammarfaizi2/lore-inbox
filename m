Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263293AbTE3GNa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 02:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbTE3GN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 02:13:29 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:62917 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263293AbTE3GNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 02:13:21 -0400
Date: Fri, 30 May 2003 08:26:36 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel@vger.kernel.org, procps-list@redhat.com,
       kernel@theoesters.com, rml@tech9.net, miquels@cistron-office.nl,
       xose@wanadoo.es, tab@tuxfamily.org
Subject: Re: [announce] procps 2.0.13 with NPTL enhancements
Message-ID: <20030530062635.GM5643@fs.tum.de>
References: <1054270854.22088.617.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054270854.22088.617.camel@cube>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 01:00:54AM -0400, Albert Cahalan wrote:
> Robert Love writes:
> On Thu, 2003-05-29 at 18:08, Adrian Bunk wrote:
> 
> >> Well, since I read Albert Cahalan's comment in
> >> Debian bug #172735 [1] I understand the people
> >> maintaining a different branch...
> >
> > Exactly.
> >
> > That bug is fixed in the official tree, fyi.
> > A segfault, as you said, is always a bug.
> > An error message is displayed.
> 
> You asked for it...
> 
> Nice cheapshot there. So, if I remove some
> critical kernel interfaces from your system,
> nothing should crash? How about I take out
> a few choice system calls or a chunk of libc?
> 
> (note: the "bug" is not exploitable)
> 
> Face it. For nearly a decade, /proc has been
> a critical kernel interface. This isn't 1991.
> (embedded systems excepted; they don't use procps)
> 
> That said, I may do something about the issue
> simply to please users with messed-up systems.
>...

Disabling the proc filesystem is simple by unchecking one item in the 
kernel config menu and different from taking out "a chunk of libc" it's 
more or less supported.

I don't say #172735 is exploitable. An error message "Error: /proc isn't 
mounted" tells you what is wrong, a segmentation fault tells you 
_nothing_.

I've seen at several occasions that several man days were lost trying to
find problems in other programs that caused segmentation faults. In the
end things like diff'ing strace files give you important hints after
hours of clueless searching. Error messages instead of segmentation
faults would have prevented several fruitless hours in my live.

After reading the last sentence you might perhaps understand my opinion
about the quality of a software whose maintainer says about a
segmentation fault "Crashing is kind of a good thing even. ... In error 
checking, there is a certain balance to achieve." .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

