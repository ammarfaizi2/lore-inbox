Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267388AbTAWXTZ>; Thu, 23 Jan 2003 18:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267399AbTAWXTZ>; Thu, 23 Jan 2003 18:19:25 -0500
Received: from bitmover.com ([192.132.92.2]:44193 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S266986AbTAWXTY>;
	Thu, 23 Jan 2003 18:19:24 -0500
Date: Thu, 23 Jan 2003 15:28:34 -0800
From: Larry McVoy <lm@bitmover.com>
To: Lee Chin <leechin@mail.com>
Cc: linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org
Subject: Re: debate on 700 threads vs asynchronous code
Message-ID: <20030123232834.GA17554@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Lee Chin <leechin@mail.com>, linux-kernel@vger.kernel.org,
	linux-newbie@vger.kernel.org
References: <20030123231913.26663.qmail@mail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030123231913.26663.qmail@mail.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> b) Write an asycnhrounous system with only 2 or three threads where I manage the connections and stack (via setcontext swapcontext etc), which is progromatically a little harder
> 
> Which way will yeild me better performance, considerng both approaches are implemented optimally?

If this is a serious question, an async system will by definition do better.
You have either 700 stacks screwing up the data cache or 2-3 stacks nicely
fitting in the data cache.  Ditto for instruction cache, etc.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
