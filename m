Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278522AbRJVLQ2>; Mon, 22 Oct 2001 07:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278525AbRJVLQS>; Mon, 22 Oct 2001 07:16:18 -0400
Received: from coruscant.franken.de ([193.174.159.226]:63151 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S278522AbRJVLQH>; Mon, 22 Oct 2001 07:16:07 -0400
Date: Mon, 22 Oct 2001 13:45:58 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: "peter k." <spam-goes-to-dev-null@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: [solved] iptables v1.2.3: can't initialize iptables table `filter': Module is wrong version
Message-ID: <20011022134558.A746@naboo.gnumonks.org>
In-Reply-To: <004801c153d6$ffc398c0$0100005a@host1> <20011013135507.B9856@vitelus.com> <00ea01c15430$345a96c0$303fe33e@host1> <20011013155259.F9856@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20011013155259.F9856@vitelus.com>; from aaronl@vitelus.com on Sat, Oct 13, 2001 at 03:52:59PM -0700
X-Operating-System: Linux naboo.gnumonks.org 2.4.9
X-Date: Today is Setting Orange, the 3rd day of The Aftermath in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2001 at 03:52:59PM -0700, Aaron Lehmann wrote:
> On Sat, Oct 13, 2001 at 11:44:14PM +0200, peter k. wrote:
> > did that, now it works! :)
> > seems like it doesnt work if i use the iptables from the mandrake rpm
> 
> I'm somewhat upset about this. Rusty, what's up? I have to recompile
> the deb against my kernel configuration for it to not myseriously
> complain.

I'm not absolutely sure about the exact cause of the problem.

It should never break (or have broken) against stock kernels.  The problem
is known in the following scenario:

a) distributor adds dropped-table (from netfilter patch-o-matic) to kernel
b) distributor builds iptables against this patched kernel
c) distributor ships this iptables
d) user installs new, plain kernel
e) iptables no longer working because it was built against a patched kernel
f) user has to recompile iptables.

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
