Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030685AbWI0Tdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030685AbWI0Tdz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 15:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030687AbWI0Tdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 15:33:55 -0400
Received: from smtp.reflexsecurity.com ([72.54.64.74]:11936 "EHLO
	crown.reflexsecurity.com") by vger.kernel.org with ESMTP
	id S1030685AbWI0Tdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 15:33:53 -0400
Date: Wed, 27 Sep 2006 15:33:43 -0400
From: Jason Lunz <lunz@falooley.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/5] UML - Assign random MACs to interfaces if necessary
Message-ID: <20060927193135.GA13322@knob.reflex>
References: <200609271757.k8RHvmgj005727@ccure.user-mode-linux.org>
In-Reply-To: <200609271757.k8RHvmgj005727@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 01:57:47PM -0400, Jeff Dike wrote:
> Now, if there is no MAC from the command line, one is generated.  We
> use the microseconds from gettimeofday (20 bits), plus the low 12
> bits of the pid to seed the random number generator.  random() is
> called twice, with 16 bits of each result used.  I didn't want to
> have to try to fill in 32 bits optimally given an arbitrary
> RAND_MAX, so I just assume that it is greater than 65536 and use 16
> bits of each random() return.

Why not use random_ether_addr() like dummy, tun, ifb and others?

Jason
