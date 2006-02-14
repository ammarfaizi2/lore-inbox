Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161025AbWBNL7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbWBNL7D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 06:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161027AbWBNL7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 06:59:03 -0500
Received: from smtp.enter.net ([216.193.128.24]:20741 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1161025AbWBNL7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 06:59:01 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Tue, 14 Feb 2006 07:08:06 -0500
User-Agent: KMail/1.8.1
Cc: luke@dashjr.org, seanlkml@sympatico.ca, sam@vilain.net,
       peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       lkml@dervishd.net, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
References: <43EB7BBA.nailIFG412CGY@burner> <200602131749.46880.luke@dashjr.org> <43F1BB4C.nailMWZ118O17@burner>
In-Reply-To: <43F1BB4C.nailMWZ118O17@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602140708.07746.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 06:13, Joerg Schilling wrote:
> Luke-Jr <luke@dashjr.org> wrote:
> > What does it do "wrong" anyway? IIRC, DMA in general works...
>
> If you really believe that it is good practice to implement DMA in
> a way so it works at some places as expected but on others not....
>
> ... then you like the Linux kernel be a junk yard :-(
>
> Good practice is to fix _all_ related code in a project in case a bug
> is identified and fixed at some place. Unfortunately this is not true
> for Linux and for this reason, Linux cannot yet be called mature.

Joerg, I think you misunderstand the problem here. The block layer itself 
supports DMA unilaterally. Some of the extended drivers that provide support 
for older hardware or, in the case of the (need I remind you) deprecated 
ide-scsi system, for an abstraction layer do not for various reasons. Whether 
that is because the device itself doesn't support DMA or if it's because the 
added complexity (in the ide-scsi case) of providing DMA for an abstraction 
layer made it nearly impossible. As the problems with ide-scsi are soon to be 
gone from main-line up-to-date kernels, I have trouble seeing why you still 
harp on this problem.

As I'm sure you know, Linux is an Open Source operating system. If you need it 
to support DMA in the ide-scsi system, then you are free to add said support. 
If you do not have the time or the skill to do so, you are also free to pay 
someone to do it for you. But as the kernel progresses through 2.6 you will 
find that most of your "bugs" are being dealt with. As a matter of fact I 
have offered to attempt to fix the problems you have with the ATAPI layer 
munging packets. As I said before, if you can provide me with the details of 
which hardware is affected and what exactly is occurring I can probably work 
on this. (And from the contents of a recent post, you can be certain I am not 
the only one interested in fixing this problem of yours)

However, if the problem is non-existant with a _modern_ kernel, then may I 
make one suggestion: remove your constant reporting of the problem.

Furthermore I have been quiet until now regarding the comments you have made 
in the source to cdrecord and libscg regarding Linux. While I appreciate that 
your software has been functional for twenty years now, I would suggest that 
you question your own motives, as it appears that your problems with Linux 
are more of a personal nature and not a technical one. Moreover I find that 
you make constant reference to "how things should have been done" but in 
looking through the Linux sources, I can find no hint that you ever touched 
the portions of the OS in question. Therefore I have to wonder if your 
abrasive manner and repeated personal attacks were not occurring even as the 
block device layer was undergoing it's last sets of rewrites and managed to 
alienate the entire crew of people working on it.

Up to this point I have attempted to be calm and civil, if not polite. However 
you preach about "good practice" and claim you will accept patches, yet in 
your stated policy you reserve the right to reject any patch on non-technical 
grounds. What's more is that you _have_ shown this to be your most common 
mode of operation, to the point of refusing to actually look at patches that 
meet the rest of the standards you provide.

I have no wish for this discussion to devolve any further, and have been 
attempting to turn it around and make it productive. Patience is something 
that I do not have in infinite quantities, however. My offers to attempt to 
fix the second of the two "major" bugs you reported stands, as does my offer 
to patch cdrecord so that it uniformly uses the b,t,l addressing scheme 
internally while allowing users to select a device node. I will let them 
stand for one week. If, at the end of that week, you have either 1) not 
provided me with the documentation I need to attempt to fix the bugs in the 
linux kernel or 2) not provided me with a written standards document on how 
code should be formatted for cdrecord patches either or both of the offers 
will be withdrawn and I will neither read nor respond to further mail from 
you.

Did I make myself clear, or should I attempt to restate that in my very rusty 
and beleagured german?

DRH
