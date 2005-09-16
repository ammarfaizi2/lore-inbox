Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161226AbVIPSYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161226AbVIPSYd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161227AbVIPSYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:24:33 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:22797 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161226AbVIPSYc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:24:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ROj2Q4AxgZ5+4gqhkkhPRaS/hiHBhuJ/Wty3dR3l9n7rEiHUlq0X8mOsDhtw8MpbMVnqoX2qa2LB7E95Vb4ZA5vYmQkjfBYEFjd3YhMwc6VKxyJOMTCZIaf5ZU/Df4PAz1cy2oGyz3+UQaT1Sogzo8YaoJGNPc7WRoRwlONarwI=
Message-ID: <12c511ca050916112428656d1@mail.gmail.com>
Date: Fri, 16 Sep 2005 11:24:31 -0700
From: Tony Luck <tony.luck@gmail.com>
Reply-To: tony.luck@gmail.com
To: Tim Bird <tim.bird@am.sony.com>
Subject: Re: early printk timings way off
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>, jesper.juhl@gmail.com,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <432B0421.3060807@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a87484905091515495f435db7@mail.gmail.com>
	 <432AFB01.3050809@am.sony.com>
	 <Pine.LNX.4.61.0509161909500.31820@gans.physik3.uni-rostock.de>
	 <Pine.LNX.4.61.0509161920370.31820@gans.physik3.uni-rostock.de>
	 <432B0421.3060807@am.sony.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrew's suggestion of a replaceable clock function would
> satisfy me.  What do other's think?

Yes please! (on ia64 we cannot use early printk() because our implementation
of sched_clock() accesses per-cpu memory, which is not mapped until long
after the first call to printk()).

-Tony
