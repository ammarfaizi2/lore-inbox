Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWBWAkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWBWAkw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 19:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWBWAkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 19:40:52 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:55446
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932384AbWBWAkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 19:40:51 -0500
Date: Wed, 22 Feb 2006 16:40:52 -0800 (PST)
Message-Id: <20060222.164052.06130115.davem@davemloft.net>
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

Please just use getpagesize(), even on sparc, that sys_mmap2() fixed
shift of 12 is a bug.
