Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSFYJY2>; Tue, 25 Jun 2002 05:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313477AbSFYJY1>; Tue, 25 Jun 2002 05:24:27 -0400
Received: from smtp-in.sc5.paypal.com ([216.136.155.8]:3465 "EHLO
	smtp-in.sc5.paypal.com") by vger.kernel.org with ESMTP
	id <S313070AbSFYJY0>; Tue, 25 Jun 2002 05:24:26 -0400
Date: Tue, 25 Jun 2002 02:24:21 -0700
From: Brad Heilbrun <bheilbrun@paypal.com>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Q] change_parent() - would this work?
Message-ID: <20020625092421.GA20315@paypal.com>
Mail-Followup-To: Thunder from the hill <thunder@ngforever.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206220435310.4307-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206220435310.4307-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 22, 2002 at 04:36:53AM -0600, Thunder from the hill wrote:
> Hi,
> 
> My question is: would this work?

I don't believe so...

> +#define change_parent(p)	list_move_tail(&(p)->sibling,&(parent)->children)

On the above line change_parent takes one argument.

> +				change_parent(p, p->parent);

Here, it takes two.

Otherwise it looks good, and removes a couple of assignments. Not sure
how useful it is though, is this done a lot?

-- 
Brad Heilbrun
