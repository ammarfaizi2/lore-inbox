Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267270AbSLELHT>; Thu, 5 Dec 2002 06:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267278AbSLELHT>; Thu, 5 Dec 2002 06:07:19 -0500
Received: from holomorphy.com ([66.224.33.161]:8842 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267270AbSLELHS>;
	Thu, 5 Dec 2002 06:07:18 -0500
Date: Thu, 5 Dec 2002 03:14:43 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: per cpu time statistics
Message-ID: <20021205111443.GA18600@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Erich Focht <efocht@ess.nec.de>, Andrew Morton <akpm@digeo.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>,
	LSE <lse-tech@lists.sourceforge.net>
References: <200212041343.39734.efocht@ess.nec.de> <3DEE3FAE.558649F5@digeo.com> <200212051157.29775.efocht@ess.nec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212051157.29775.efocht@ess.nec.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 11:57:29AM +0100, Erich Focht wrote:
> My patch is basically the reverting patch plus changed ifdefs and a
> bunch of Kconfig entries. I'd be happy to get this feature back, no
> matter how it is implemented. I think it is necessary for performance
> analysis on HT, NUMA, SMT systems.

32-bit is not irrelevant, but there's certainly a 64-bit land where
the critical 32-bit correctness issue becomes a minor 64-bit
performance issue. This is the nature of extended 32-bit addressing.
By and large what is a severe and world-breaking correctness issue for
32-bit with extended addressing is a performance issue for the rest.

And so I feel we are all in harmony; the scheduler statistics are in
fact valuable on all platforms, it's just an question of basic "should
this overhead be required or optional?"


Bill
