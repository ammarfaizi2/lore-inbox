Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVB1HpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVB1HpA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 02:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVB1HpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 02:45:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:1455 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261201AbVB1Ho6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 02:44:58 -0500
Date: Sun, 27 Feb 2005 23:44:08 -0800
From: Greg KH <greg@kroah.com>
To: Eric Gaumer <gaumerel@ecs.fullerton.edu>
Cc: Alexey Dobriyan <adobriyan@mail.ru>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] orinoco rfmon
Message-ID: <20050228074407.GA25480@kroah.com>
References: <4220BB87.2010806@ecs.fullerton.edu> <200502262259.30897.adobriyan@mail.ru> <4220FC1D.6010404@ecs.fullerton.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4220FC1D.6010404@ecs.fullerton.edu>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2005 at 02:45:49PM -0800, Eric Gaumer wrote:
> What is the difference between u* and uint*_t ? Both are derived from the 
> same basic data type.
> 
> typedef unsigned char __u8;
> typedef         __u8            uint8_t;
> 
> And...
> 
> typedef unsigned char u8;

Don't use the uint*_t types, they are not correct.  See the lkml
archives for why this is true.

Use the u8 for when you are in the kernel, and __u8 when you need it for
a variable that crosses the userspace/kernelspace barrier.

thanks,

greg k-h
