Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWCMV6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWCMV6l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 16:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWCMV6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 16:58:38 -0500
Received: from smtp101.biz.mail.re2.yahoo.com ([68.142.229.215]:42596 "HELO
	smtp101.biz.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932478AbWCMV60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 16:58:26 -0500
From: Pantelis Antoniou <pantelis@embeddedalley.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Which kernel is the best for a small linux system?
Date: Tue, 14 Mar 2006 00:00:44 +0200
User-Agent: KMail/1.8.2
Cc: Arjan van de Ven <arjan@infradead.org>,
       j4K3xBl4sT3r <jakexblaster@gmail.com>, linux-kernel@vger.kernel.org,
       Dan Malek <dan@embeddedalley.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <436c596f0603121640h4f286d53h9f1dd177fd0475a4@mail.gmail.com> <1142237867.3023.8.camel@laptopd505.fenrus.org> <20060313182725.GA31211@mars.ravnborg.org>
In-Reply-To: <20060313182725.GA31211@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603140000.45052.pantelis@embeddedalley.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 March 2006 20:27, Sam Ravnborg wrote:
> On Mon, Mar 13, 2006 at 09:17:47AM +0100, Arjan van de Ven wrote:
> > On Sun, 2006-03-12 at 21:40 -0300, j4K3xBl4sT3r wrote:
> > > Hello all,
> > > 
> > > I've been seeing many Linux versions, with many features, some of them
> > > just for the newest branches (2.4.x and 2.6.x), I would like to know
> > > for which kind of system each kernel is recommended. On the distros
> > > that we see inside the Net there is the 2.4.x series, normally I
> > > update to 2.6.x (in case of my Slackware 10.2, even getting problems
> > > with some devices). Is that floppy disks uses only 2.0.x and 2.2.x
> > > Kernels? If applicable, where can I get (detailed) information about
> > > these issues? I'm new on Kernel managing, started doing my own distros
> > > at less than one month and would like to know it.
> > 
> > regardless of the size issue; you should really not start any new
> > projects based on 2.4 kernels; they are in deep deep maintenance mode
> > for now, but it's unclear how long they will be (I suppose as long as
> > people keep sending patches), especially complex security issues should
> > worry people ;)
> > 
> > 2.6 is actively maintained and will be for quite some time :)
> 
> Any comments on this:
> http://www.denx.de/wiki/Know/Linux24vs26
> 
> On another denx.de page I found this summary (so you do not have to
> visit the page):
> # slow to build: 2.6 takes 30...40% longer to compile
> # Big memory footprint in flash: the 2.6 compressed kernel image is
> # 30...40% bigger
> # Big memory footprint in RAM: the 2.6 kernel needs 30...40% more RAM;
> # the available RAM size for applications is 700kB smaller
> # Slow to boot: 2.6 takes 5...15% longer to boot into multi-user mode
> # Slow to run: context switches up to 96% slower, local communication
> # latencies up to 80% slower, file system latencies up to 76% slower,
> # local communication bandwidth less than 50% in some cases.
> 
> I'm merely asked because I have been pointed to this page several times
> and I do nto have numbers for 2.4 versus 2.6.
> 
> Note: denx does support 2.6 now.
> 
> I do not concur and recommend 2.6 but wanted to know if anyone had more
> insight to share.
> 
> 	Sam
> -

Hi there.

Since I've been dealing with those platforms quite a lot, let me have
my $0.02.

Yes 2.6 is larger than 2.4 and with small embedded processors with small
caches & a small number of TLBs that footprint is felt quite a lot.

For the 8xx which shows the biggest performance, later kernels offer 
the CONFIG_PIN_TLB option which help quite a bit.

So for anything new I'd recommend 2.6 anyway, the performance delta
is not so great as this test appears to show. I'd like this test to be performed
again against a newer kernel version if possible.

Pantelis
