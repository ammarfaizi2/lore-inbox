Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266597AbUFWSfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266597AbUFWSfd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 14:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266483AbUFWSfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 14:35:33 -0400
Received: from [66.199.228.3] ([66.199.228.3]:51727 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id S266597AbUFWSfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 14:35:30 -0400
Date: Wed, 23 Jun 2004 11:35:29 -0700
From: David Ashley <dash@xdr.com>
Message-Id: <200406231835.i5NIZTSJ019899@xdr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Cached memory never gets released
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is some new information that might be useful. The cache memory
lower limit seems to be going up by 1 or 2 megabytes whenever the kernel
kills the XFree86 process:
Jun 23 11:20:16 __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Jun 23 11:20:16 VM: killing process XFree86

Could it be when the kernel kills a process for trying to use up too much
memory, the pages used by the process get left in some locked state so can
never be reused?

This is the sort of behaviour we're seeing, it is very reproduceable.


Note this is kernel 2.4.23.

-Dave
