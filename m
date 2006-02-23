Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751610AbWBWAl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbWBWAl1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 19:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbWBWAl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 19:41:26 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:56214
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751610AbWBWAl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 19:41:26 -0500
Date: Wed, 22 Feb 2006 16:41:27 -0800 (PST)
Message-Id: <20060222.164127.35786912.davem@davemloft.net>
To: hpa@zytor.com
Cc: klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: sys_mmap2 on different architectures
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43FCFC53.20505@zytor.com>
References: <43FCDB8A.5060100@zytor.com>
	<20060222.135430.44726149.davem@davemloft.net>
	<43FCFC53.20505@zytor.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin" <hpa@zytor.com>
Date: Wed, 22 Feb 2006 16:05:39 -0800

> Okay, what I'll do is that I'll hard-code 12 on i386, SPARC and ARM; on 
> other architectures I'll use getpagesize().  Of course, on 64-bit 
> architectures this is not an issue; there I just call sys_mmap.

Oh and BTW if you use 12 it will break when executing on a
64-bit kernel, where PAGE_SHIFT is variable and starting at
13.
