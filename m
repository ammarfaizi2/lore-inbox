Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262291AbVGAHxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbVGAHxI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 03:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVGAHxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 03:53:08 -0400
Received: from styx.suse.cz ([82.119.242.94]:5806 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262291AbVGAHxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 03:53:05 -0400
Date: Fri, 1 Jul 2005 09:53:04 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deinline sleep/delay functions
Message-ID: <20050701075304.GA2041@ucw.cz>
References: <200506300852.25943.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506300852.25943.vda@ilport.com.ua>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 08:52:25AM +0300, Denis Vlasenko wrote:
> Hi Andrew,
> 
> Optimizing delay functions for speed is utterly pointless.
> 
> This patch turns ssleep(n), mdelay(n), udelay(n) and ndelay(n)
> into functions, thus they generate the smallest possible code
> at the callsite. Previously they were more or less inlined.

Optimizing mdelay() and udelay() for speed is pointless, but optimizing
ndelay() makes a lot of sense - if the setup time (call, etc) of the
delay is large, the delay time will be off by many percent. 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
