Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965191AbVI0X1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965191AbVI0X1v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 19:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbVI0X1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 19:27:51 -0400
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:33547
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S1751165AbVI0X1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 19:27:49 -0400
Date: Tue, 27 Sep 2005 16:14:42 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Luben Tuikov <luben_tuikov@adaptec.com>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
In-Reply-To: <4339CCD6.5010409@adaptec.com>
Message-ID: <Pine.LNX.4.10.10509271604510.14637-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Luben,

Welcome to the club ...

You have managed to prove your knowledge base and forgot everything
learned in kindergarden.  Since I have kids, and spent time back in
kindergarden, there are some valuable lessons there many have forgotten.

>From what I have seen here, both sides have some valid points.

>From what I know from history and why I no longer maintain anything,
(working to get sanity back) is the Maintainer defines direction while
following a bigger picture.

The issues wrt to HCIL v/s WWN v/s Multiplier v/s Target-Mode v/s blahblah
blahblah are important questions.

Remember, everything about storage is a lie.

Help create a better lie by mapping into the design set forward by James
and company.  If the goal of Adaptec is to have support then they need to
buckup and play be to rules at hand.  Remember, most people are open to
new ideas and better models.  Propose one and you will find backing.

Since you are in the bay-area ... want to met who you have been associated
with ... or is the idea to weird?

Cheers,

Andre


On Tue, 27 Sep 2005, Luben Tuikov wrote:

> On 09/27/05 17:55, Jeff Garzik wrote:
> > * Avoids existing SAS code, rather than working with it.
> 
> No, it's the _other_ way around.  There is NO existing
> SAS code.
> 
> My SAS code has been around _long_ before Christophs
> code.
> 
> Christoph's code is
>  * MPT based only,
>  * doesn't follow a spec to save its life,
>  * far inferior in SAS capabilities and SAS representation
>    again, due to the fact that it is MPT based.
> 
> Since the whole point of MPT is to _hide_ the transport.
> 
> > * Avoids existing SATA code, rather than working with it.
> 
> FUD!  Why?  It does _not_ use SATA code at all.
> 
> Why?  SATA devices are discovered on the domain, but
> there is _no_ SATL in the kernel to represent them.
> 
> And libata is _not_ SATL.  The reasons are that
> libata is closely coupled to the hardware, i.e.
> ata_port.
> 
> While in SAS open transport architecures, you'd have
> execute ATA/SAS/SMP task just as you have in aic-94xx.
> Why? Because all the chip is, is an interface to the
> interconect.
> 
> But I'm sure you know all this having looked at the
> specs of BCM8603.
> 
> > * Avoids (rather than fix) several SCSI core false dependencies on HCIL. 
> >   Results in code duplication and/or avoidance of needed code.
> 
> No, not true.  It _integrates_ with SCSI Core.  The sad truth
> is that SCSI Core knows only HCIL.
> 
> Jeff, please be more specific.
> 
> > * So far, it's an Adaptec-only solution.  Since it pointedly avoids the 
> > existing SAS transport code, this results in two SAS solutions in Linux: 
> > one for Adaptec, one for {everyone else}.
> 
> Hmm, again: _architecture_.  And you have to stop these
> accusations: "pointedly avoids the existing SAS transport code".
> 
> I repeat again that I had this code _long_ before Christoph
> ever dreamt up SAS.  And he got my code via James B sometime
> before OLS this year.  I think he got it July 12, 2005.
> 
> The question is: why didn't _he_ use the solution already
> available?
> 
> You have to understand the differences between MPT and open
> transport architecture.
> 
> At some point I thought Christoph seemed to have understood it.
> Now I'm not sure any more.
> 
> Now since the open transport solution completely encompasses
> and _absolves_ MPT, it is not hard for an MPT driver to
> generate a bunch of events and use that infrastructure.
> 
> > * Maintainer reminds me of my ATA mentor, Andre Hedrick:  knows his 
> > shit, but has difficulties working with the community.  May need a 
> > filter if we want long term maintenance to continue.
> 
> I take offence in your liking me to Andre -- I don't know
> Andre personally, but is seems that you're expressing personal
> opinion against him, against me and labeling me in some way.
> 
> I take offence in that, Jeff.
> 
> Why are you making this a _political_ and personal game?
> 
> All you're doing is trying to aliken me to someone and
> brandish me as someone I'm not.
> 
> This is rude, offensive and done in desperation.
> 
> Shall we concentrate on the _technical_ part of
> the argument?
> 
> I repeat again: _technical_ part of the argument.
> 
> > Easy path: make Adaptec's solution a block driver, which allows it to 
> > sidestep all the "doesn't play well with others" issues.  Still an 
> 
> What _exactly_ does it mean "don't play well with others"?
> 
> Do you mean:
>  - the solution is far superiour to anything available now
>  - it presents the SAS Domain in sysfs as it looks in
>    the physical world,
>  - does domain discovery and expander configuration,
>  - allows for complete control of the domain to user space,
>  - it pokes at SCSI Core's 20 year old relics.
>  - it's a thorn in the flesh to other people striving for
>    similar functionality.
> 
> Or do you mean:
>  - it does not change a single line of code in the kernel,
>  - does not break anything existing,
>  - etc, etc.
> 
> > Adaptec-only solution, but at least its in a separate playpen.
> 
> I'm sure James Bottomley will move from SCSI Core to the block
> layer as he did for IDR. hehehe :-)
> 
> And no, it is not Adaptec's only solution.  Your BCM8603 SAS
> LLDD when you write it could use it without any problems.
> 
> > Hard path: Update the SCSI core and libata to work with SATA+SAS 
> > hardware such as Adaptec's.
> 
> Cannot do for libata -- ever.  Why?  You know best: because
> libata uses direct access to the hardware!  There is no
> layered architecture.
> 
> What you need to do is to write a SATL layer, just as you can
> see in SAT-r6, page 2, Figure 3.  I'm on top of this already.
> 
> But in order to do this you need a unified architecture
> for accessing ATA devices.
> 
> Now libata, uses ata_port to do this, which is _hardware_
> access.
> 
> The SAS Transport layer uses Execute SCSI RPC (defined
> in SAM, provided by aic94xx) to do this.
> 
> So in effect, what SATL would end up to be is a
> data transformation function.   But I digress...
> 
> > The hard path takes time, and won't be solved simply by shoving it in.
> 
> No, you can do it now.  It will not affect anyone or anything.
> (Other than hurting a couple of people's pride.)
> 
> The code doesn't alter Linux SCSI or anyone else's behaviour.
> It only _provides_ SAS support to the kernel.
> 
> Including it in as is would does not hurt anyone as you can
> see here:
> http://linux.adaptec.com/sas/git/
> 
> Concentrate on the _technical_ merit, let's be more specific.
> 
> 	Luben
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

