Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVCCQCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVCCQCA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 11:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVCCQCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 11:02:00 -0500
Received: from orb.pobox.com ([207.8.226.5]:31197 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261892AbVCCQBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 11:01:40 -0500
Date: Thu, 3 Mar 2005 08:01:37 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303160137.GD9796@ip68-4-98-123.oc.oc.cox.net>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 02:21:38PM -0800, Linus Torvalds wrote:
> So the suggestion on the table would be to go back to even/odd, but do it 
> at the "micro-level" of single releases, rather than make it a two- or 
> three-year release cycle.

[WARNING: At this point I have pulled an all-nighter, for reasons
unrelated to Linux. I may not be making sense anymore. This will
probably be my last post in this thread for today, or maybe even
forever.]

Is a 1:1 ratio necessarily the correct one? IOW, maybe alternatives like
the following should be considered (S = stable, ES = extra-stable, EES =
extra-extra-stable):

       | odd/even | ES every 5th | S, ES, EES, ...
---------------------------------------------------
2.6.11 | S        | S            | S
2.6.12 | ES       | S            | ES
2.6.13 | S        | S            | S (align for EES on divisible by 3)
2.6.14 | ES       | S            | ES
2.6.15 | S        | ES           | EES
2.6.16 | ES       | S            | S
2.6.17 | S        | S            | ES
2.6.18 | ES       | S            | EES
2.6.19 | S        | S            | S
2.6.20 | ES       | ES           | ES
2.6.21 | S        | S            | EES
2.6.22 | ES       | S            | S
...

e.g. if odd/even causes too many long releases or other problems like
that, then something like the middle column (every Nth release is
extra-stable, for N >= 3) could be tried.

-Barry K. Nathan <barryn@pobox.com>
