Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269981AbTHGPd1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270081AbTHGPd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:33:27 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:18181 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S269981AbTHGPbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:31:21 -0400
Subject: Re: Interactivity improvements
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Patrick McLean <pmclean@cs.ubishops.ca>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3F3261A2.9000405@cs.ubishops.ca>
References: <3F3261A2.9000405@cs.ubishops.ca>
Content-Type: text/plain
Message-Id: <1060270276.762.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 07 Aug 2003 17:31:17 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-07 at 16:26, Patrick McLean wrote:

> Finally, the interactivity estimator seems to be quite a bit of code, 
> which certain people have no real useful (in servers for example) and I 
> would imagine that it does reduce throughput, which is not a big deal in 
> desktops, but in a server environment it's not good, so maybe a 
> CONFIG_INTERACTIVE_ESTIMATOR or something similar would be an idea to 
> keep the server people happy, just have an option to completely get rid 
> of the extra overhead of having a really nice interactivity estimator. I 
> could be an idiot though, and I imagine that I will be needing some 
> asbestos for saying this, but I thought I would voice my opinion.

In the past, I proposed to have at least 2 schedulers available (much
like we have for I/O schedulers): one for servers, which doesn't mess
with bonuses and interactivity too much and gives best throughput for
batch processing (OLTP and in general, non-interactive loads), and
another one for desktops or Terminal Servers.

Don't know if this is feasible, however.

