Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263254AbVCMFTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263254AbVCMFTn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 00:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263243AbVCMFTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 00:19:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2236 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263254AbVCMFTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 00:19:05 -0500
Date: Sat, 12 Mar 2005 21:18:56 -0800
Message-Id: <200503130518.j2D5IuAo025165@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andi Kleen <ak@muc.de>
X-Fcc: ~/Mail/linus
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Bad patch to schedule()
In-Reply-To: Andi Kleen's message of  , 9 March 2005 13:02:51 +0100 <20050309120251.GA4374@muc.de>
X-Zippy-Says: I'm changing the CHANNEL..  But all I get is commercials for
   ``RONCO MIRACLE BAMBOO STEAMERS''!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> called from schedule(). The problem with this is that it completely
> messes up the register allocation for i386 schedule() because it 
> does long long arithmetic. This causes gcc to spill everything
> else because it needs four registers, and i386 only has 6 usable
> ones.

The generated code I've seen does not bear out this claim.  If you are
using ancient compilers and they produce poor code, then it is time to move
on.  If you are using some recent gcc, then you'll have to show the
concrete details since they don't match what I see.


Thanks,
Roland
