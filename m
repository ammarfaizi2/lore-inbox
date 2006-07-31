Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWGaXnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWGaXnX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 19:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWGaXnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 19:43:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:25512 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751400AbWGaXnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 19:43:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gJASJUYiHzbj4jo+JIMjZxKn+15gVfB4m1sL2jrllYUf8Wrj8xpWpnpF+R89p4aLobtq2rluuBt1XPqXSRqOPi3EQoeIWbuzBX9dM3NWZp4Xx6LnNmc5r6+oIVySA6/7Ci31nv2vCXDL002J1Q3dbxpoYMu/dnH7/u4S3nCUNwQ=
Message-ID: <5c49b0ed0607311643r61570665ga4d8a70beaeb17f@mail.gmail.com>
Date: Mon, 31 Jul 2006 16:43:11 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Cc: "Gregory Maxwell" <gmaxwell@gmail.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Clay Barnes" <clay.barnes@gmail.com>,
       "Rudy Zijlstra" <rudy@edsons.demon.nl>,
       "Adrian Ulrich" <reiser4@blinkenlights.ch>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
In-Reply-To: <44CE97AD.7030300@wolfmountaingroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1153760245.5735.47.camel@ipso.snappymail.ca>
	 <20060731173239.GO31121@lug-owl.de>
	 <20060731181120.GA9667@merlin.emma.line.org>
	 <20060731184314.GQ31121@lug-owl.de>
	 <20060731191712.GE17206@HAL_5000D.tc.ph.cox.net>
	 <1154374923.7230.99.camel@localhost.localdomain>
	 <e692861c0607311400x412d2e6bv71f474ea959c9e00@mail.gmail.com>
	 <44CE7C11.7020202@wolfmountaingroup.com>
	 <5c49b0ed0607311556s50b77c07o150497f8e4bd3fd3@mail.gmail.com>
	 <44CE97AD.7030300@wolfmountaingroup.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/06, Jeff V. Merkey <jmerkey@wolfmountaingroup.com> wrote:
> Nate Diller wrote:
>
> > On 7/31/06, Jeff V. Merkey <jmerkey@wolfmountaingroup.com> wrote:
> >
> >> Gregory Maxwell wrote:
> >>
> >> > On 7/31/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >> >
> >> >> Its well accepted that reiserfs3 has some robustness problems in the
> >> >> face of physical media errors. The structure of the file system
> >> and the
> >> >> tree basis make it very hard to avoid such problems. XFS appears
> >> to have
> >> >> managed to achieve both robustness and better data structures.
> >> >>
> >> >> How reiser4 compares I've no idea.
> >> >
> >> >
> >> > Citation?
> >> >
> >> > I ask because your clam differs from the only detailed research that
> >> > I'm aware of on the subject[1]. In figure 2 of the iron filesystems
> >> > paper that Ext3 is show to ignore a great number of data-loss inducing
> >> > failure conditions that Reiser3 detects an panics under.
> >> >
> >> > Are you sure that you aren't commenting on cases where Reiser3 alerts
> >> > the user to a critical data condition (via a panic) which leads to a
> >> > trouble report while ext3 ignores the problem which suppresses the
> >> > trouble report from the user?
> >> >
> >> > *1) http://www.cs.wisc.edu/adsl/Publications/iron-sosp05.pdf
> >>
> >> Hi Gregory, Wikimedia Foundation and LKML?
> >>
> >> How's Wikimania going. :-)
> >>
> >> What he says is correct.  I have seen some serious issues with reiserfs
> >> in terms of stability and
> >> data corruption.  Resier is however FASTER, but the statement is has
> >> robustness issues is accurate.
> >> I was using reiserfs but we opted to make EXT3 the default for Solera
> >> appliances, even when using Suse 10
> >> due to issues I have seen with data corruption and hard hangs on RAID 0
> >> read/write sector errors.  I have
> >> stopped using it for local drives and based everything on EXT3.  Not to
> >> say it won't get there eventually, but
> >> file systems have to endure a lot of time in the field and deployment
> >> befor they are ready for prime time.
> >>
> >> The Wikimedia appliances use Wolf Mountain, and I've tested it for about
> >> 4 months with few problems, but
> >> I only use it for hosting the Cherokee Langauge Wikipedia.  It's
> >> performance is several magnitudes better
> >> than either EXT3 or ReiserFS.  Despite this, for vertical wiki servers,
> >> its ok to go out with, folks can specifiy
> >> whether they want appliances with EXT3, Reiser, or WMFS, but iit's a
> >> long way from being "cooked"
> >> completely, though it does scale to 1 exabyte FS images.
> >
> >
> > i've seen you mention the Wolf Mountain FS in other emails, but google
> > isn't telling me a lot about it.  Do you have a whitepaper?  are there
> > any published benchmark results?  what sort of workloads do you
> > benchmark?
> >
> > NATE
> >
> Wikipedia is the app for now.  I have not done any benchmarks on the FS
> side, just the capture side, and its been transferred to
> another entity.  I have no idea what they are naming it to, but I expect
> you may hear about it soon.  One of the incarnations
> of it is Solera's DSFS which can be reviewed here:
>
> www.soleranetworks.com

so this is a single stream, write only? ...

> I can sustain 850 MB/S throughput from user space with it -- about 5 x
> any other FS.  On some hardware, I've broken
> the 1.25 GB/S (gigabyte/second) windows with it.

and you're saying it scales to much higher multi-spindle
single-machine throughput.  cool.

i'd love to see a whitepaper, or failing that, have an off-list
discussion of your approach and the various kernel limitations you ran
up against in testing.  i don't suppose they invited you to the Kernel
Summit to talk about it, heh.

NATE
