Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267984AbUJJBBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267984AbUJJBBF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 21:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267986AbUJJBBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 21:01:05 -0400
Received: from web13708.mail.yahoo.com ([216.136.175.141]:63911 "HELO
	web13708.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267984AbUJJBAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 21:00:52 -0400
Message-ID: <20041010010051.73780.qmail@web13708.mail.yahoo.com>
Date: Sat, 9 Oct 2004 18:00:51 -0700 (PDT)
From: Martins Krikis <mkrikis@yahoo.com>
Subject: Re: [Announce] "iswraid" (ICH5R/ICH6R ataraid sub-driver) for 2.4.28-pre3
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
In-Reply-To: <58cb370e04100916441c1b74d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On Sat, 9 Oct 2004 16:03:00 -0700 (PDT), Martins Krikis
> <mkrikis@yahoo.com> wrote:
> > --- Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl> wrote:
> > 
> > > I may sound like an ignorant but...
> > >
> > > Why can't device mapper be merged into 2.4 instead?
> > 
> > "Instead" is the key word here... That would mean that
> > Boji's and my work has been largely in vain and that the
> > driver that to my best knowledge currently provides the
> > simplest (from a user's point of view) cooperation with
> > Intel RAID OROM and the most comlete feature-set regarding
> > Intel RAID metadata interpretation and updates would not
> > make it to the kernel. I have nothing against device mapper
> > being merged into 2.4 but I don't consider that a fair
> > reason for not considering iswraid.
> 
> Well, in some way this speaks against merging iswraid in 2.4.
> If it provides "the most comlete feature-set regarding Intel RAID
> metadata interpretation and updates" then merging it would
> create regression when compared to 2.6, wouldn't it?

Are you trying to say that "iswraid might look too good"
compared to what is currently available on 2.6 and therefore
should not be considered for inclusion in 2.4? A most interesting
reason indeed, I'm glad I said "fair" higher above, which it
certainly wouldn't be. Now, if such criteria were applied
against all new work, wouldn't that discourage new people
from contributing?

> > > Is there something wrong with 2.4 device mapper patch?
> > 
> > I don't think so. However, I do believe that iswraid has
> > some advantages, one of them being the ability to just link
> > it statically with the rest of the kernel and not needing
> > any user-space support code, i.e., initrd is not necessary.
> 
> Yep, no doubt it is easier to use but harder to maintain.

Which is why it is the 2.6 kernel way. As for 2.4,
iswraid exists and I was planning to take responsibility
for it. Not that I'm a kernel expert, but I believe I
know what I was trying to put in iswraid.
 
> > Also, I do not believe that dm+dmraid are currently
> > capable of updating the Intel RAID metadata in case of
> > errors. Please correct me if I'm wrong.
> 
> again "regression" argument is valid here

OK. I already replied above to that.

> > > It would more convenient (same driver for 2.4 and 2.6)
> > > and would benefit users of other software RAIDs
> > > (easier transition to 2.6).
> > 
> > If you expect the transitioning from ataraid to dm+dmraid
> > to be so hard that it is best to do it separately from
> > the switch to a 2.6 kernel, then I think 2 things are true:
> 
> Maybe not hard but inconvinient.
> 
> > 1) there might be something positive about the simple
> > usage of ataraid subdrivers,
> 
> Yep.
> 
> > 2) the users of Intel RAID metadata might benefit by
> > having two drivers supporting them in 2.4 kernels---the
> > one with the "simple, ataraid-style" usage and "the one
> > for the future".
> 
> Yep.
> 
> > My email archive and the feedback on iswraid's project
> > page actually contains many requests for an iswraid port
> > to 2.6. Which I'm reading as a sign that some users
> > actually like it.
> 
> iswraid and 2.6 is a no go for obvious reason (no ataraid)

Actually, that is not the reason. There is very little
dependence on ataraid in iswraid. It would be quite easy
to make iswraid a completely standalone driver. It has not 
been ported to 2.6 primarily because it would not be welcome
there, but I never expected any animosity towards it in 2.4. 

> > The main features of iswraid are listed in
> > Documentation/iswraid.txt, almost at the top of the file.
> > I believe that several of them distingiush it from
> > other ataraid subdrivers in a positive way, and there
> > was certainly a lot of hard work that went into this driver.
> 
> No doubt about that.
> 
> I'm fine with merging iswaid into 2.4 but it is a bit shame that
> the same amount of work didn't go into improving Intel RAID
> support in 2.6.

It still might and hopefully will, and I do believe that iswraid
has already helped advance Intel RAID metadata support in dmraid.
Heinz is the judge of that. More work was put into 2.4 because
those were the specific business requirements at the time.
Don't ask me more---I am just a coder and do not work for any
group that may be involved with ICH{5,6}.

  Martins Krikis
  Storage Components Division
  Intel Massachusetts



		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com
