Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWJCNns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWJCNns (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 09:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWJCNns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 09:43:48 -0400
Received: from THUNK.ORG ([69.25.196.29]:8423 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750821AbWJCNnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 09:43:47 -0400
Date: Tue, 3 Oct 2006 09:38:45 -0400
From: Theodore Tso <tytso@mit.edu>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Dan Williams <dcbw@redhat.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, jt@hpl.hp.com,
       Andrew Morton <akpm@osdl.org>, Norbert Preining <preining@logic.at>,
       hostap@shmoo.com, linux-kernel@vger.kernel.org,
       ipw3945-devel@lists.sourceforge.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061003133845.GG2930@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	"John W. Linville" <linville@tuxdriver.com>,
	Dan Williams <dcbw@redhat.com>,
	Alessandro Suardi <alessandro.suardi@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, jt@hpl.hp.com,
	Andrew Morton <akpm@osdl.org>, Norbert Preining <preining@logic.at>,
	hostap@shmoo.com, linux-kernel@vger.kernel.org,
	ipw3945-devel@lists.sourceforge.net
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> <20061002111537.baa077d2.akpm@osdl.org> <20061002185550.GA14854@bougret.hpl.hp.com> <200610022147.03748.rjw@sisk.pl> <1159822831.11771.5.camel@localhost.localdomain> <20061002212604.GA6520@thunk.org> <5a4c581d0610021508hdc331f0w7c9b71c3944d4d8b@mail.gmail.com> <1159877574.2879.11.camel@localhost.localdomain> <20061003124902.GB23912@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003124902.GB23912@tuxdriver.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 08:49:07AM -0400, John W. Linville wrote:
> As Dan points-out, it will be a while before distros (other than
> Fedora rawhide and equivalents) have 2.6.19 kernels for general
> users.  For now, those experiencing this issue should be comfortable
> experiencing some breakage...?
> 
> So, is the window between now and the release of 2.6.19 big enough
> to give the distros time to get wireless-tools and wpa_supplicant
> into their update streams?  Or do we need to go through the pain of
> reverting/delaying WE-21?

There is a fundamental question hiding here, which is whether or not
it is acceptable to break users who are running some large set of
mainline distro's, such as RHEL 4, SLES/SLED 10, Ubuntu Dapper,
et. al, but who want to upgrade to a newer 2.6 kernel?

Many users have moved to Ubuntu Dapper, or RHEL 4, or SLES/SLED 10
because they don't want to deal with a constantly changing/breaking
GNOME/X world, where packages are constantly being updated and
possibly breaking their desktop.  Some of these users are in fact
kernel developers, who want to live and test on the bleeding edge, but
who don't want to deal with an unstable Desktop/X world, since that's
not where their expertise lies.  Other users are ones which have to
use a mainstream distribution for one reason or another (maybe they
have software that only works on RHEL 4), but are interested in
testing bleeding edge kernels because they want to help contribute to
testing and quality assurance.  Is it acceptable to break them with
ABI changes?

If the answer that it is acceptable to break the "slower moving"
distro's, how much time do we need to allow to elapse before the
"faster moving" distro's have accepted the necessary userspace bits?
Is it 30 days?  60 days? 90 days?  Or do we do it by distribution.  If
all of Debian testing, Ubuntu development, Fedora Core n and n-1,
OpenSuse, Gentoo, has accepted the newer bits, is that enough time?

Clearly the wireless updates failed the second series of tests; but we
haven't even decided, amongst kernel developers, under what
circumstances is it permissible to break the first set of distro's.
Clearly in the best of all worlds new interfaces are carefully
documented, and no new interface is introduced without thinking very
carefully about forwards and backwards compatibility.  Unfortuately,
the wireless ABI interface is a legacy interface which seems to be
really broken in many different ways.

John, has the wireless community considered creating a new interface
which *is* carefully designed, and supporting both the new and the
legacy interface for 2-3 years until all of the mainstream
distributions have had a chance to cycle?  It would be hard, I know,
but would it be harder than some of the alternatives, and would it be
worth it?

Regards,

						- Ted
