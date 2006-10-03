Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750696AbWJCMRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750696AbWJCMRx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 08:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWJCMRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 08:17:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38554 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750696AbWJCMRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 08:17:52 -0400
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
From: Dan Williams <dcbw@redhat.com>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Theodore Tso <tytso@mit.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       jt@hpl.hp.com, Andrew Morton <akpm@osdl.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       linux-kernel@vger.kernel.org, ipw3945-devel@lists.sourceforge.net
In-Reply-To: <5a4c581d0610021508hdc331f0w7c9b71c3944d4d8b@mail.gmail.com>
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at>
	 <20061002111537.baa077d2.akpm@osdl.org>
	 <20061002185550.GA14854@bougret.hpl.hp.com>
	 <200610022147.03748.rjw@sisk.pl>
	 <1159822831.11771.5.camel@localhost.localdomain>
	 <20061002212604.GA6520@thunk.org>
	 <5a4c581d0610021508hdc331f0w7c9b71c3944d4d8b@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 08:12:53 -0400
Message-Id: <1159877574.2879.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-6.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 00:08 +0200, Alessandro Suardi wrote:
> On 10/2/06, Theodore Tso <tytso@mit.edu> wrote:
> > On Mon, Oct 02, 2006 at 05:00:31PM -0400, Dan Williams wrote:
> > > Distributions _are_ shipping those tools already.  The problem is more
> > > with older distributions where, for example, the kernel gets upgraded
> > > but other stuff does not.  If a kernel upgrade happens, then the distro
> > > needs to make sure userspace works with it.  That's nothing new.
> >
> > Um, *which* distro's are shipping it already?  RHEL4?  SLES10?  I
> > thought we saw a note saying that even Debian **unstable** didn't have
> > a new enough version of the wireless-tools....
> 
> That was my point initially. FC5-latest is apparently carrying
>  tools which are "too old"... and I yum update twice or thrice
>  a week. Not that *I* minded building packages from source,
>  but this is likely a bit too much for a good slice of the userbase.

And that's my fault.  I was made aware of this issue last week and am
currently testing out the newer wireless-tools with the intention of
pushing them to FC5-updates.  Had I actually been tracking the
wireless-tools release cycle more closely, I would have pushed the
wireless-tools-28 final version when it came out.

But, as far as I know (please correct me if I'm wrong), that 2.6.18
doesn't actually include WE-21! [1]  Somebody is trying to run
out-of-kernel ipw3945 drivers using a 2.6.18 kernel from FC5 that's
WE-20 only, but the driver uses WE-21?

ipw3945 isn't in the upstream kernel, and Fedora certainly isn't going
to go out of its way to make sure every piece of software under the sun
that's not included in the distro works with it [2].  Distros try to
make sure they are internally consistent, not globally consistent.  If
somebody uses out-of-kernel drivers, they take that responsibility.  The
solution to the problem is to make sure that ipw3945 gets in the kernel
as quickly as possible, something I think we'd all like to have happen.

Dan

[1] /lib/modules/2.6.18-1.2708.fc6/build/include/linux/wireless.h
defines WIRELESS_EXT = 20

[2] Yeah it would be nice; but go out of the way to have Skype w/ OSS,
Nvidia binary drivers, ATI binary drivers, ndiswrapper,
out-of-kernel-drivers?  No.

> Ciao,
> 
> --alessandro
> 
> "Well a man has two reasons for things that he does
>   the first one is pride and the second one is love
>   all understandings must come by this way"
> 
>      (Husker Du, 'She Floated Away')

