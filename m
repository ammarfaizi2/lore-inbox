Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUHSM6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUHSM6T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 08:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUHSM6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 08:58:19 -0400
Received: from penguin.cohaesio.net ([212.97.129.34]:42982 "EHLO
	mail.cohaesio.net") by vger.kernel.org with ESMTP id S261724AbUHSM6M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 08:58:12 -0400
From: Anders Saaby <as@cohaesio.com>
Organization: Cohaesio A/S
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: oom-killer 2.6.8.1
Date: Thu, 19 Aug 2004 14:58:17 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200408181455.42279.as@cohaesio.com> <200408181624.25131.as@cohaesio.com> <20040818211142.GH11200@holomorphy.com>
In-Reply-To: <20040818211142.GH11200@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408191458.17551.as@cohaesio.com>
X-OriginalArrivalTime: 19 Aug 2004 12:58:11.0603 (UTC) FILETIME=[2EBB7630:01C485EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 August 2004 23:11, William Lee Irwin III wrote:
> On Wednesday 18 August 2004 16:05, William Lee Irwin III wrote:
> >> Index: oom-2.6.8-rc1/mm/vmscan.c
> >> ===================================================================
> >> --- oom-2.6.8-rc1.orig/mm/vmscan.c	2004-07-14 06:17:13.876343912 -0700
> >> +++ oom-2.6.8-rc1/mm/vmscan.c	2004-07-14 06:22:15.986416200 -0700
> >> @@ -417,7 +417,8 @@
> >>  				goto keep_locked;
> >>  			if (!may_enter_fs)
> >>  				goto keep_locked;
> >> -			if (laptop_mode && !sc->may_writepage)
> >> +			if (laptop_mode && !sc->may_writepage &&
> >> +							!PageSwapCache(page))
> >>  				goto keep_locked;
> >>
> >>  			/* Page is dirty, try to write it out here */
>
> On Wed, Aug 18, 2004 at 04:24:24PM +0200, Anders Saaby wrote:
> > laptop_mode is not set on this server <- :-)
> > - So I guess this is not relevant for my setup?
>
> Probably not. Please try to collect /proc/slabinfo snapshots while the
> system is still functional as it degrades.
>
OK, I am now collecting /proc/slabinfo every hour to some logfiles - I will 
send you the results when I have some interesting data.

/Saaby

>
> -- wli
