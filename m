Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265840AbUATXQL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 18:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265841AbUATXQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 18:16:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:25541 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265840AbUATXQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 18:16:00 -0500
Date: Tue, 20 Jan 2004 15:15:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Maciej Zenczykowski <maze@cela.pl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i386/mm and openwall change
In-Reply-To: <Pine.LNX.4.44.0401210000370.13857-100000@gaia.cela.pl>
Message-ID: <Pine.LNX.4.58.0401201513520.2123@home.osdl.org>
References: <Pine.LNX.4.44.0401210000370.13857-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Jan 2004, Maciej Zenczykowski wrote:
> 
> If it doesn't matter why set the bit at all?  If we do set the least
> significant bit this is obviously because it shouldn't be zero (i.e. it
> doesn't matter as long as it's boolean true), if so then why does ow set
> it to zero in this case.  Obviously this is somehow _weird_...

The error code is _not_ a boolean. It's several bits, and it so happens 
that only the low bit matters for kernel space accesses. And it doesn't 
actually matter whether it is set (2.6.x) or not (2.4.x), it should just 
be fixed.

		Linus
