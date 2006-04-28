Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbWD1Hjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWD1Hjh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 03:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbWD1Hjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 03:39:36 -0400
Received: from mail.gmx.de ([213.165.64.20]:9652 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030301AbWD1Hjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 03:39:36 -0400
X-Authenticated: #14349625
Subject: Re: [PATCH 0/9] CPU controller
From: Mike Galbraith <efault@gmx.de>
To: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
In-Reply-To: <20060428162612.7760628d.maeda.naoaki@jp.fujitsu.com>
References: <20060428013730.9582.9351.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
	 <1146201936.7523.15.camel@homer>
	 <20060428144859.a07bb5b2.maeda.naoaki@jp.fujitsu.com>
	 <1146207589.7551.7.camel@homer>
	 <20060428162612.7760628d.maeda.naoaki@jp.fujitsu.com>
Content-Type: text/plain
Date: Fri, 28 Apr 2006 09:41:09 +0200
Message-Id: <1146210069.7551.31.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-28 at 16:26 +0900, MAEDA Naoaki wrote:
> On Fri, 28 Apr 2006 08:59:49 +0200
> Mike Galbraith <efault@gmx.de> wrote:
> > You simply cannot ignore interactive tasks.  At the very least, you have
> > to disallow requeue if the resource limit has been exceeded, otherwise,
> > this patch set is non-functional.
> 
> It can be easily implemented on top of the current code. Do you know a good
> sample program that is judged as interactive but consumes lots of cpu?

X sometimes, Mozilla sometimes,... KDE konsole when scrolling,...
anything that on average sleeps more than roughly 5% of it's slice can
starve you to death either alone, or (worse) with peers.

	-Mike

