Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbTI1SDu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 14:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbTI1SDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 14:03:50 -0400
Received: from holomorphy.com ([66.224.33.161]:40095 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262677AbTI1SDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 14:03:49 -0400
Date: Sun, 28 Sep 2003 11:04:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] No Swap. Re: [BUG 2.6.90-test5] kernel shits itself with 48mb ram under moderate load
Message-ID: <20030928180450.GN4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ihar 'Philips' Filipau <filia@softhome.net>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ArQ0.821.25@gated-at.bofh.it> <ArQ0.821.21@gated-at.bofh.it> <ArZC.8f1.9@gated-at.bofh.it> <3F75EC3B.4030305@softhome.net> <20030927202148.GA31080@k3.hellgate.ch> <3F76DCEC.60508@softhome.net> <Pine.LNX.4.58.0309281747460.13202@artax.karlin.mff.cuni.cz> <3F771893.1020405@softhome.net> <Pine.LNX.4.58.0309281922050.17752@artax.karlin.mff.cuni.cz> <3F77203F.8010704@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F77203F.8010704@softhome.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 28, 2003 at 07:54:07PM +0200, Ihar 'Philips' Filipau wrote:
>   That's what matters. Try to work in vim if it is permanently get 
> swaped out. _*Very*_ _*very*_ not nice.
>   And there is no memory pressure - kernel just decided to enlarge I/O 
> cache... 100% stupid.
>   I personally prefer to have statical I/O cache - never saw it working 
> reliably with dynamic allocation.

This is a different question from what I had in mind. There are some
controls in 2.6.x to control the relative tendencies to evict unmapped
pagecache vs. unmapping etc. anonymous memory. I'd try adjusting
/proc/sys/vm/swappiness and reporting how (in)effective that is, then
if that still doesn't work, various things can be adjusted.


-- wli
