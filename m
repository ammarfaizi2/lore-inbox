Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270575AbTGaWkf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 18:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274886AbTGaWkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:40:35 -0400
Received: from holomorphy.com ([66.224.33.161]:61657 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S270575AbTGaWke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:40:34 -0400
Date: Thu, 31 Jul 2003 15:41:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Panic on 2.6.0-test1-mm1
Message-ID: <20030731224148.GJ15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <5110000.1059489420@[10.10.2.4]> <20030731223710.GI15452@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731223710.GI15452@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 03:37:10PM -0700, William Lee Irwin III wrote:
> You've applied mingo's patch, which needs to check for PAE in certain
> places like the above. Backing out highpmd didn't make this easier, it
> just gave you performance problems because now all your pmd's are stuck
> on node 0 and another side-effect of those changes is that you're now
> pounding pgd_lock on 16x+ boxen. You could back out the preconstruction
> altogether, if you're hellbent on backing out everyone else's patches
> until your code has nothing to merge against.

I also did the merging of pgtable.c for highpmd and the preconstruction
code correctly, sent it upstream, and it got ignored in favor of code
that does it incorrectly, oopses, and by some voodoo gets something else
I wrote dropped while remaining incorrect.

You may now put the "aggravated" magnet beneath the "wli" position on
the fridge.


-- wli
