Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWARDcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWARDcp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 22:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWARDcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 22:32:45 -0500
Received: from mail.cs.umn.edu ([128.101.36.202]:59091 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id S964890AbWARDcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 22:32:45 -0500
Date: Tue, 17 Jan 2006 21:32:39 -0600
From: Dave C Boutcher <sleddog@us.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Ingo Molnar <mingo@elte.hu>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org,
       paulus@au1.ibm.com, anton@au1.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm4 failure on power5
Message-ID: <20060118033239.GA621@cs.umn.edu>
Reply-To: boutcher@cs.umn.edu
Mail-Followup-To: Michael Ellerman <michael@ellerman.id.au>,
	Ingo Molnar <mingo@elte.hu>, "Serge E. Hallyn" <serue@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org,
	paulus@au1.ibm.com, anton@au1.ibm.com, linux-kernel@vger.kernel.org
References: <20060116063530.GB23399@sergelap.austin.ibm.com> <200601180032.46867.michael@ellerman.id.au> <20060117140050.GA13188@elte.hu> <200601181119.39872.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601181119.39872.michael@ellerman.id.au>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 11:19:36AM +1100, Michael Ellerman wrote:
> It booted fine _with_ the patch applied, with DEBUG_MUTEXES=y and n.
> 
> Boutcher, to be clear, you can't boot with kernel-kernel-cpuc-to-mutexes.patch 
> applied and DEBUG_MUTEXES=y ?
> 
> But if you revert kernel-kernel-cpuc-to-mutexes.patch it boots ok?
> 
> This is looking quite similar to another hang we're seeing on Power4 iSeries 
> on mainline git:
> http://ozlabs.org/pipermail/linuxppc64-dev/2006-January/007679.html

Correct...I die in exactly the same place every time with
DEBUG_MUTEXES=Y.  I posted a backtrace that points into the _lock_cpu
code, but I haven't really dug into the issue yet.  I believe this is
very timing related (Serge was dying slightly differently).

-- 
Dave Boutcher
