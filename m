Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265287AbUGGSaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbUGGSaN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 14:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265290AbUGGSaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 14:30:13 -0400
Received: from palrel13.hp.com ([156.153.255.238]:1772 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S265287AbUGGSaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 14:30:05 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16620.16681.811228.597631@napali.hpl.hp.com>
Date: Wed, 7 Jul 2004 11:30:01 -0700
To: Jack Steiner <steiner@sgi.com>
Cc: davidm@hpl.hp.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - Reduce TLB flushing during process migration
In-Reply-To: <20040707154800.GA17818@sgi.com>
References: <20040623143844.GA15670@sgi.com>
	<20040623143318.07932255.akpm@osdl.org>
	<16605.1322.355489.223220@napali.hpl.hp.com>
	<20040702173905.GA18884@sgi.com>
	<16619.15708.487344.93894@napali.hpl.hp.com>
	<20040707154800.GA17818@sgi.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 7 Jul 2004 10:48:00 -0500, Jack Steiner <steiner@sgi.com> said:

  Jack> As far as the tlb_migrate patch is concerned, the change to
  Jack> the way machvec noop functions are implemented is mostly
  Jack> unrelated to the tlb_migrate patch. We can apply the patches
  Jack> in 2 ways:

  Jack> - change machvec noop functions
  Jack> - rework the tlb_migrate patch on top of that change

  Jack> OR

  Jack> - apply the tlb_migrate patch in it's current form
  Jack> - change the machvec noop functions including the tlb_migrate noop

  Jack> Either works. I'm partial to #2 (easier) but will do either....

I'd be ok with #2 except that if we do it that way, I bet that we'll
forget about changing the machvec noop functions... ;-)

  Jack> Note: calling a noop function after an explicit process
  Jack> migration is untidy but is not a measurable performance
  Jack> problem. I agree, however, that the noop function should be
  Jack> improved. At some point in the future, other noop functions
  Jack> may be added that ARE performance sensitive. It is good to
  Jack> have the correct infrastructure implemented.

Precisely.

	--david
