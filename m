Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129216AbRCHQlX>; Thu, 8 Mar 2001 11:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129240AbRCHQlN>; Thu, 8 Mar 2001 11:41:13 -0500
Received: from [64.64.109.142] ([64.64.109.142]:58125 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S129216AbRCHQlF>; Thu, 8 Mar 2001 11:41:05 -0500
Message-ID: <3AA7B5C8.22D8DC7E@didntduck.org>
Date: Thu, 08 Mar 2001 11:39:36 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Rothwell <rothwell@holly-springs.nc.us>
CC: linux-kernel@vger.kernel.org
Subject: Re: opening files in /proc, and modules
In-Reply-To: <200103081651.f28GpkQ04042@513.holly-springs.nc.us>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Rothwell wrote:
> 
> How can I detect that open() has been called on a file in procfs that a
> module provides? If I modprobe my module, open one or more if its proc
> entries, then rmmod the module while the proc files are still open, then
> the deletion of those entries is deferred. When I close the file(s), the
> kernel oopses. I need to be able to detect open() and close() in order
> to increment/decrement the reference count for my module, to prevent it
> from being rmmoded when in use. Any tips?
> 
> Thanks!

Really, the procfs needs a pointer to the module so it can do the
reference before calling the code in the module.

--

				Brian Gerst
