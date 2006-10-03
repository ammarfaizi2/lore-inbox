Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030310AbWJCQBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbWJCQBd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 12:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbWJCQBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 12:01:33 -0400
Received: from THUNK.ORG ([69.25.196.29]:31141 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030393AbWJCQBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 12:01:31 -0400
Date: Tue, 3 Oct 2006 12:00:41 -0400
From: Theodore Tso <tytso@mit.edu>
To: Dan Williams <dcbw@redhat.com>
Cc: "John W. Linville" <linville@tuxdriver.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, jt@hpl.hp.com,
       Andrew Morton <akpm@osdl.org>, Norbert Preining <preining@logic.at>,
       hostap@shmoo.com, linux-kernel@vger.kernel.org,
       ipw3945-devel@lists.sourceforge.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061003160041.GC29333@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Dan Williams <dcbw@redhat.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Alessandro Suardi <alessandro.suardi@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, jt@hpl.hp.com,
	Andrew Morton <akpm@osdl.org>, Norbert Preining <preining@logic.at>,
	hostap@shmoo.com, linux-kernel@vger.kernel.org,
	ipw3945-devel@lists.sourceforge.net
References: <20061002111537.baa077d2.akpm@osdl.org> <20061002185550.GA14854@bougret.hpl.hp.com> <200610022147.03748.rjw@sisk.pl> <1159822831.11771.5.camel@localhost.localdomain> <20061002212604.GA6520@thunk.org> <5a4c581d0610021508hdc331f0w7c9b71c3944d4d8b@mail.gmail.com> <1159877574.2879.11.camel@localhost.localdomain> <20061003124902.GB23912@tuxdriver.com> <20061003133845.GG2930@thunk.org> <1159884779.2855.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159884779.2855.18.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 10:12:59AM -0400, Dan Williams wrote:
> I'd point out here that one is not breaking the _distro_, as long as we
> assume that distros are internally consistent (which one of the major
> points of a distro!).  What's getting broken is people who
> install/replace distro-provided software with their own bits.  In the
> first case, the distro people are responsible to making sure that
> breakage does not occur, and that distro users are not affected.  In the
> second case, that responsibility falls to the user who
> installed/replaced the distro-provided software, precisely because that
> software is no longer distro provided.

I'm using short-hand here.  When I say breaking the _distro_, what I
mean is that we are breaking the ability for users of that distro to
test development kernels, which is generally considered a good thing
by the kernel development community.  

One could make the case that telling them that they have to download
something relatively trivial, like wireless tools, is less of a big
deal than something huge and very painful to build and replace, like
glibc (with udev, hal, et. al, probably falling somewhere in between
these two extremes), but up until now, the goal that kernel
development has made is that we add new interfaces, but we try
extremely hard not to break existing interfaces without a lot of
notice.  

Consider that that the normal, MINIMUM waiting period for *removing*
an interface or functionality is six months.  I would argue that this
means that we should be waiting that long before making
backwards-incompatible changes to an interface should be at least that
long.

> Yes, nl80211/cfg80211 (sent to netdev@ last week) is the likely
> successor.  Please, if you have suggestions for ABI/API-proofability,
> review the patch and post suggestions!  We all know a carefully designed
> is not just about the code, but about the semantics, structures, etc as
> well.  It would be quite valuable to have everyone's input to make sure
> it's as future-proof as possible.

As a suggestion, has someone written up the a formal interface
specification?  If so, posting that for review along with the code
might be a good idea.  

Regards,

						- Ted
