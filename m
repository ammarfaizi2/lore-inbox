Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269540AbRHCScF>; Fri, 3 Aug 2001 14:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269543AbRHCSb4>; Fri, 3 Aug 2001 14:31:56 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:14347 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S269540AbRHCSbq>; Fri, 3 Aug 2001 14:31:46 -0400
Date: Fri, 3 Aug 2001 20:31:53 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: David Weinehall <tao@acc.umu.se>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
Message-ID: <20010803203153.G31468@emma1.emma.line.org>
Mail-Followup-To: David Weinehall <tao@acc.umu.se>,
	Daniel Phillips <phillips@bonn-fries.net>,
	"Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <20010801170230.B7053@redhat.com> <20010802110341.B17927@emma1.emma.line.org> <01080219261601.00440@starship> <20010802193750.B12425@emma1.emma.line.org> <20010803105029.I6387@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010803105029.I6387@khan.acc.umu.se>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Aug 2001, David Weinehall wrote:

> On Thu, Aug 02, 2001 at 07:37:50PM +0200, Matthias Andree wrote:
> > Still, some people object to a dirsync mount option. But this has been
> > the actual reason for the thread - MTA authors are refusing to pamper
> > Linux and use chattr +S instead which gives unnecessary (premature) sync
> > operations on write() - but MTAs know how to fsync().
> 
> So what you mean is that MTA authors refuse to pamper Linux through use
> of fsync of the directory, but can accept to "pamper" Linux through use
> of chattr +S?! This seem ridiculous.  It seems equally ridiculous to
> demand that Linux should pamper for MTA authors that can't implement
> fsync on the directory instead of writing BSD-specific code.

It's a maintenance issue.

You effectively start wrapping up all relevant syscalls and have
system-specific interfaces. One wants the directory fsync()ed, the other
offers a special other trick to get the data flushed... what useful is
portability then if systems are so different?

> To me this seems mostly like a way of saying "Hey, we've finally found
> a way to make Linux look really bad compared to BSD-systems; let's

No wonder if the application chooses fully-synchronous operation on
Linux.

-- 
Matthias Andree
