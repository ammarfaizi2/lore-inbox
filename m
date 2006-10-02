Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965119AbWJBVB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbWJBVB3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbWJBVB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:01:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38077 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965119AbWJBVB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:01:27 -0400
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
From: Dan Williams <dcbw@redhat.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: jt@hpl.hp.com, Andrew Morton <akpm@osdl.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       Norbert Preining <preining@logic.at>,
       Alessandro Suardi <alessandro.suardi@gmail.com>, hostap@shmoo.com,
       linux-kernel@vger.kernel.org, ipw3945-devel@lists.sourceforge.net
In-Reply-To: <200610022147.03748.rjw@sisk.pl>
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at>
	 <20061002111537.baa077d2.akpm@osdl.org>
	 <20061002185550.GA14854@bougret.hpl.hp.com>
	 <200610022147.03748.rjw@sisk.pl>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 17:00:31 -0400
Message-Id: <1159822831.11771.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-6.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 21:47 +0200, Rafael J. Wysocki wrote:
> On Monday, 2 October 2006 20:55, Jean Tourrilhes wrote:
> > On Mon, Oct 02, 2006 at 11:15:37AM -0700, Andrew Morton wrote:
> > > On Mon, 02 Oct 2006 12:58:24 -0400
> > > > 
> > > > You have a mismatch between your wireless-tools, your kernel, and/or
> > > > wpa_supplicant.  WE-21 uses the _real_ ssid length rather than the
> > > > kludge of hacking off the last byte used previously.  Please ensure that
> > > > your tools, driver, and kernel are using WE-21.
> > > > 'cat /proc/net/wireless' should tell you what your kernel is using.
> > > > Getting the driver WE is a bit harder and you may have to look at the
> > > > source.
> > > 
> > > Jean, John: the amount of trouble which this change is causing is quite
> > > high considering that we're not even at -rc1 yet.  It's going to get worse.
> > 
> > 	We have to split between the different issues we have seen.
> > 	Tools issue (the wpa_supplicant problem). -> those can only be
> > fixed by people upgrading. Fortunately, there are not so many tools
> > affected, and new version of those tools were released last
> > April/May. As I said, most distro have those in the pipe.
> > 	In-Kernel driver issues (the Orinoco driver problem). -> those
> > can be patched and fixed as we go along. I would not worry about
> > those.
> > 	Out-of-kernel issues (the ipw3945 driver problem). -> those
> > drivers need to be updated. That's the problem of living outside the
> > kernel. Very often those drivers are reactive with respect to kernel
> > API changes, rather than pro-active, so there is not much we can do.
> > 
> > > It doesn't sound like it'll be too hard to arrange for the kernel to
> > > continue to work correctly with old userspace?
> > 
> > 	Actually, it's impossible. New userspace can work across both
> > version, old userspace fails on new version.
> 
> <rant>
> Well, please tell me now what number of people actually _will_ upgrade?

If you're using a distro, the distro maintainers should be making sure
versions are compatible.  If you don't, well, then you need to be making
sure versions are compatible.

> And if they don't, will they use the -rc kernels?  No, they won't, because
> of the apparent wireless breakage.
> 
> This way we loose quite a few testers and the entire development
> process is affected, and that's _only_ because you have decided it
> will be _convenient_ to change the ABI.  However, such changes affect
> _everyone_ and in a wrong way, except for a few people who actually want the
> change.  They cause more damage than they are worth, so they should be avoided
> at all reasonable cost.
> 
> It would be fair to introduce the change when distributions actually ship the
> userland tools capable of handling it, but not _now_.

Distributions _are_ shipping those tools already.  The problem is more
with older distributions where, for example, the kernel gets upgraded
but other stuff does not.  If a kernel upgrade happens, then the distro
needs to make sure userspace works with it.  That's nothing new.

Dan

> </rant>
> 
> Greetings,
> Rafael
> 
> 

