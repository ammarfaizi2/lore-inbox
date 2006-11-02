Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752849AbWKBNXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbWKBNXR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 08:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752867AbWKBNXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 08:23:17 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:20915 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1752868AbWKBNXP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 08:23:15 -0500
Date: Thu, 2 Nov 2006 16:22:52 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Balbir Singh <balbir@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Thomas Graf <tgraf@suug.ch>,
       Shailabh Nagar <nagar@watson.ibm.com>, Jay Lan <jlan@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] taskstats: factor out reply assembling
Message-ID: <20061102132252.GB3387@oleg>
References: <20061101182611.GA447@oleg> <45497E75.6050401@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45497E75.6050401@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02, Balbir Singh wrote:
>
> Oleg Nesterov wrote:
> > +
> > +	aggr = TASKSTATS_TYPE_AGGR_TGID;
> > +	if (type == TASKSTATS_TYPE_PID)
> > +		aggr = TASKSTATS_TYPE_AGGR_PID;
> 
> How about using
> 
> aggr = (type == TASKSTATS_TYPE_PID) ? TASKSTATS_TYPE_AGGR_PID  :
> 				TASKSTATS_TYPE_AGGR_TGID;

I personally think this is much better. In fact, i did exactly same, but
then changed it because (I think) CodingStyle police doesn't like '?:'.

Or it does?

Oleg.

