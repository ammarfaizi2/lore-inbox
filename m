Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWFUGCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWFUGCR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 02:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWFUGCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 02:02:17 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:4087 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S1751145AbWFUGCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 02:02:16 -0400
Date: Wed, 21 Jun 2006 15:02:12 +0900 (JST)
Message-Id: <20060621.150212.138089156.jet@gyve.org>
To: hpa@zytor.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] sharing maximum errno symbol used in __syscall_return
 (i386)
From: Masatake YAMATO <jet@gyve.org>
In-Reply-To: <4498C95A.3090909@zytor.com>
References: <20060620.184010.225581173.jet@gyve.org>
	<4498C95A.3090909@zytor.com>
X-Mailer: Mew version 4.2.53 on Emacs 22.0.51 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi,
> > 
> > __syscall_return in unistd.h is maintained?
> > 
> > In the macro the value returned from system call is
> > compared with the maximum error number defined in a header file 
> > to know the call is successful or not. However, the maximum error number 
> > is hard-coded and is not updated.
> > 
> 
> And it's wrong, anyway.  It has long been agreed that the maximum errno 
> value, for any architecture, is 4095.

So we should do just:


   #define GENERIC_ERRNO_MAX 4095

Here my patch is proved to be useful for maintaining __syscall_return:-P
 
Masatake YAMATO
