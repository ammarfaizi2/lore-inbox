Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265283AbUGANvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265283AbUGANvg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 09:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbUGANvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 09:51:36 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53641 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265283AbUGANvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 09:51:32 -0400
Date: Thu, 1 Jul 2004 15:11:59 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>, vojtech@suse.cz
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       PARISC list <parisc-linux@lists.parisc-linux.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix the cpumask rewrite
Message-ID: <20040701131158.GP698@openzaurus.ucw.cz>
References: <1088266111.1943.15.camel@mulgrave> <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org> <1088268405.1942.25.camel@mulgrave> <Pine.LNX.4.58.0406260948070.14449@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406260948070.14449@ppc970.osdl.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> And the same is true of "volatile" for the bitop functions. They are 
> volatile not because they require the data to be volatile, but because 
> they have at least traditionally been used for various cases, _including_ 
> volatile.
> 
> Now, we could say that we don't do that any more, and decide that the 
> regular bitop functions really cannot be used on volatile stuff. But 
> that's a BIG decision. And it's certainly not a decision that parisc 
> users should make.

Heh, with vojtech we introduced locking into input layer
(there was none before)... using test_bit/set_bit.

(I just hope set_bit etc implies memory barrier... or we'll have to do
it once more)

			Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

