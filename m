Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932603AbVJCVWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbVJCVWd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 17:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbVJCVWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 17:22:33 -0400
Received: from free.hands.com ([83.142.228.128]:39905 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S932603AbVJCVWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 17:22:32 -0400
Date: Mon, 3 Oct 2005 22:22:27 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Valdis.Kletnieks@vt.edu
Cc: Vadim Lobanov <vlobanov@speakeasy.net>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051003212227.GK8548@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <Pine.LNX.4.63.0510021704210.27456@cuia.boston.redhat.com> <20051002230545.GI6290@lkcl.net> <Pine.LNX.4.58.0510021637260.28193@shell2.speakeasy.net> <20051003005400.GM6290@lkcl.net> <200510030255.j932toIK012248@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510030255.j932toIK012248@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2005 at 10:55:49PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 03 Oct 2005 01:54:00 BST, Luke Kenneth Casson Leighton said:
> 
> >  in the mid-80s), hardware cache line lookups (which means
> >  instead of linked list searching, the hardware does it for
> >  you in a single cycle), stuff like that.
> 
> OK.. I'll bite.  How do you find the 5th or 6th entry in the linked list,
> when only the first entry is in cache, in a single cycle, when a cache line
> miss is more than a single cycle penalty, and you have several "These are not
> the droids you're looking for" checks and go on to the next entry - and do it
> in one clock cycle?
 
  i was not privy to the design discussions: unfortunately i was only
  given brief conclusions and hints by the designer.

  my guess is that yes, as the later messages in this thread
  hint at, CAM is probably the key: 256 blocks of 32-bit CAM,
  something like that.

  CAM is known to help dramatically decrease execution time
  by orders of magnitude in linked list algorithms such as
  searching and sorting, esp. where each CAM cell has built-in
  processing, like the aspex.net massively-deep SIMD architecture has.

  l.

