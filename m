Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263751AbTLVTxQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 14:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbTLVTxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 14:53:16 -0500
Received: from stinkfoot.org ([65.75.25.34]:49316 "EHLO stinkfoot.org")
	by vger.kernel.org with ESMTP id S263751AbTLVTxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 14:53:15 -0500
Message-ID: <3FE74B8D.8020006@stinkfoot.org>
Date: Mon, 22 Dec 2003 14:52:45 -0500
From: Ethan Weinstein <lists@stinkfoot.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: Hans-Peter Jansen <hpj@urpla.net>, linux-kernel@vger.kernel.org
Subject: Re: minor e1000 bug
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDD75@orsmsx402.jf.intel.com>
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDD75@orsmsx402.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Feldman, Scott wrote:
> 
> e100 and e1000 both query h/w for stats on a timer (2 seconds) and cache
> the results.  A call into the driver's get_stats function just returns
> these cached values.  With e100, there is a problem in that issuing the
> command to dump stats doesn't return right away, so rather than blocking
> in the driver by waiting for the command to complete, the driver just
> reads the results of the dump command 2 seconds prior, and then reissues
> a new dump command.  So e100 stats are delayed by ~2 seconds.
> 
> 3c59x (and others) query the h/w for stats in the driver's get_stats
> function directly.  This gives up-to-date stats.  We could do this with
> e1000, but it'll take a little bit of surgery because there is some
> other code in the driver that is dependent on stats collected over 2
> second period.  Nothing that can't be fixed.
> 

It'd be fantastic if we could get this implememted. I'm very pleased 
with the quality of this driver save for this one small issue.  I'd be 
glad to help test code if necessary as I have multiple systems using 
e1000's, and several are testboxes.  It'd be nice to have some 
semi-realtime stats from these cards.


-Ethan


