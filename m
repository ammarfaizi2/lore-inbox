Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263799AbUEXB2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263799AbUEXB2o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 21:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbUEXB2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 21:28:44 -0400
Received: from holomorphy.com ([207.189.100.168]:17542 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263799AbUEXB2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 21:28:43 -0400
Date: Sun, 23 May 2004 18:28:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jakob Oestergaard <jakob@unthought.net>, Phy Prabab <phyprabab@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Help understanding slow down
Message-ID: <20040524012828.GK1833@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jakob Oestergaard <jakob@unthought.net>,
	Phy Prabab <phyprabab@yahoo.com>, linux-kernel@vger.kernel.org
References: <20040524003200.14639.qmail@web90007.mail.scd.yahoo.com> <20040524005751.62303.qmail@web90006.mail.scd.yahoo.com> <20040524010455.GJ1833@holomorphy.com> <20040524012553.GG30687@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524012553.GG30687@unthought.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 03:25:53AM +0200, Jakob Oestergaard wrote:
> Eh, not if I read the numbers right:
> 2.6.7-p1: 24.86user 51.77system 2:58.87elapsed 42%CPU
> 24.86 + 51.77 = 76.63 seconds on CPU, 102.24 seconds of waiting
> 2.4.21: 28.68user 34.98system 1:12.34elapsed 87%CPU
> 28.68 + 34.98 = 63.66 seconds on CPU, 8.68 seconds of waiting
> So, 2.6.7-p1 spends 16.79 seconds more in the kernel as you observed,
> but it spends 93.56 seconds more waiting for I/O (or whatever).
> Unless I'm totally missing something, the wait seems to be the
> regression.

I'm sorry, you're right. Let's start by looking into IO activity.
Phy, could you log the output of vmstat(1) during the runs?


-- wli
