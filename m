Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbVK3WuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbVK3WuQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 17:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVK3WuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 17:50:15 -0500
Received: from [139.30.44.16] ([139.30.44.16]:25871 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1751215AbVK3WuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 17:50:14 -0500
Date: Wed, 30 Nov 2005 23:50:11 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@osdl.org>,
       Marcelo Feitoza Parisi <marcelo@feitoza.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvidia-agp: use time_before_eq()
In-Reply-To: <20051130213902.GB12551@mipter.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.63.0511302346480.13505@gockel.physik3.uni-rostock.de>
References: <20051130213902.GB12551@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2005, Alexey Dobriyan wrote:

> It deals with wrapping correctly and is nicer to read.

> -			if ((signed)(end - jiffies) <= 0) {
> +			if (time_before_eq(end, jiffies)) {

It'd be even nicer to read if it were
			if (time_after_eq(jiffies, end)) {
like the other users of these macros.

Tim
