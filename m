Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVHGBLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVHGBLy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 21:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVHGBJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 21:09:39 -0400
Received: from fsmlabs.com ([168.103.115.128]:14310 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261402AbVHGBHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 21:07:19 -0400
Date: Sat, 6 Aug 2005 19:13:00 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] i386: Per node IDT
In-Reply-To: <42D28DE4.B5B17853@tv-sign.ru>
Message-ID: <Pine.LNX.4.61.0508061906050.470@montezuma.fsmlabs.com>
References: <42D26604.66A75939@tv-sign.ru> <Pine.LNX.4.61.0507110747480.16055@montezuma.fsmlabs.com>
 <42D285CD.CF9389F8@tv-sign.ru> <42D28DE4.B5B17853@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2005, Oleg Nesterov wrote:

> Oleg Nesterov wrote:
> > 
> > Probably it makes sense to change it to
> >         pushl $vector - 0xFFFF - 1
> > 
> 
> Please note that entry.S:BUILD_INTERRUPT() also does this trick:
> 	pushl $nr-256;
> 
> so it should be changed as well.

I was making these changes and noticed that those were for the various SMP 
interrupts so they are real vectors. These will always remain within the 
256 range.

	Zwane

