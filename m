Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWCMWdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWCMWdZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbWCMWdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:33:25 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:53521 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964820AbWCMWdY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:33:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MPICymrfgmbH092Twlk6B6icM15y+rlT38cmgWMuw2Jm8xss9vQp15VxjEPoqV7iUCBce8IyLdkiQ50sZ9znf/R434Ocx7rFEOs6eGg6E2vimQugeANnkIghsLOcXaSu9b1+DZiLV3oGCuZrvgXsK5RsjrVMctsTCjYE3RK+Cvk=
Message-ID: <436c596f0603131433m37ff30c2q6f1eccb809324388@mail.gmail.com>
Date: Mon, 13 Mar 2006 19:33:22 -0300
From: j4K3xBl4sT3r <jakexblaster@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Which kernel is the best for a small linux system?
In-Reply-To: <200603140020.19602.pantelis@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436c596f0603121640h4f286d53h9f1dd177fd0475a4@mail.gmail.com>
	 <200603140000.45052.pantelis@embeddedalley.com>
	 <436c596f0603131401l479dd4b5q164017f701b37289@mail.gmail.com>
	 <200603140020.19602.pantelis@embeddedalley.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/06, Pantelis Antoniou <pantelis@embeddedalley.com> wrote:
> On Tuesday 14 March 2006 00:01, j4K3xBl4sT3r wrote:
> > On 3/13/06, Pantelis Antoniou <pantelis@embeddedalley.com> wrote:
> > > On Monday 13 March 2006 20:27, Sam Ravnborg wrote:
> > > > On Mon, Mar 13, 2006 at 09:17:47AM +0100, Arjan van de Ven wrote:
> > > > > On Sun, 2006-03-12 at 21:40 -0300, j4K3xBl4sT3r wrote:
> > > > > > Hello all,
> > > > > >
> > > > > > I've been seeing many Linux versions, with many features, some of them
> > > > > > just for the newest branches (2.4.x and 2.6.x), I would like to know
> > > > > > for which kind of system each kernel is recommended. On the distros
> > > > > > that we see inside the Net there is the 2.4.x series, normally I
> > > > > > update to 2.6.x (in case of my Slackware 10.2, even getting problems
> > > > > > with some devices). Is that floppy disks uses only 2.0.x and 2.2.x
> > > > > > Kernels? If applicable, where can I get (detailed) information about
> > > > > > these issues? I'm new on Kernel managing, started doing my own distros
> > > > > > at less than one month and would like to know it.
> > > > >
> > > > > regardless of the size issue; you should really not start any new
> > > > > projects based on 2.4 kernels; they are in deep deep maintenance mode
> > > > > for now, but it's unclear how long they will be (I suppose as long as
> > > > > people keep sending patches), especially complex security issues should
> > > > > worry people ;)
> > > > >
> > > > > 2.6 is actively maintained and will be for quite some time :)
> > > >
> > > > Any comments on this:
> > > > http://www.denx.de/wiki/Know/Linux24vs26
> > > >
> > > > On another denx.de page I found this summary (so you do not have to
> > > > visit the page):
> > > > # slow to build: 2.6 takes 30...40% longer to compile
> > > > # Big memory footprint in flash: the 2.6 compressed kernel image is
> > > > # 30...40% bigger
> > > > # Big memory footprint in RAM: the 2.6 kernel needs 30...40% more RAM;
> > > > # the available RAM size for applications is 700kB smaller
> > > > # Slow to boot: 2.6 takes 5...15% longer to boot into multi-user mode
> > > > # Slow to run: context switches up to 96% slower, local communication
> > > > # latencies up to 80% slower, file system latencies up to 76% slower,
> > > > # local communication bandwidth less than 50% in some cases.
> > > >
> > > > I'm merely asked because I have been pointed to this page several times
> > > > and I do nto have numbers for 2.4 versus 2.6.
> > > >
> > > > Note: denx does support 2.6 now.
> > > >
> > > > I do not concur and recommend 2.6 but wanted to know if anyone had more
> > > > insight to share.
> > > >
> > > >       Sam
> > > > -
> > >
> > > Hi there.
> > >
> > > Since I've been dealing with those platforms quite a lot, let me have
> > > my $0.02.
> > >
> > > Yes 2.6 is larger than 2.4 and with small embedded processors with small
> > > caches & a small number of TLBs that footprint is felt quite a lot.
> > >
> > > For the 8xx which shows the biggest performance, later kernels offer
> > > the CONFIG_PIN_TLB option which help quite a bit.
> > >
> > > So for anything new I'd recommend 2.6 anyway, the performance delta
> > > is not so great as this test appears to show. I'd like this test to be performed
> > > again against a newer kernel version if possible.
> > >
> > > Pantelis
> > >
> >
> > so, in the case of the big footprints, might I use a 2.4.x instead of
> > 2.6.x just to avoid memory leaks and performance loss?
> >
> > j4k3.
> >
>
> What memory leaks? And cut it out with 1337 speak. It stopped
> being funny 10 years ago...
>
> Pantelis
>

OffTopic: lol @pantelis, so how would be "memory leak" in leet lang? =p
