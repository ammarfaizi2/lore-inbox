Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265117AbUBIMxu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 07:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbUBIMxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 07:53:50 -0500
Received: from intra.cyclades.com ([64.186.161.6]:155 "EHLO intra.cyclades.com")
	by vger.kernel.org with ESMTP id S265117AbUBIMxs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 07:53:48 -0500
Date: Mon, 9 Feb 2004 10:26:47 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, "Moore, Eric Dean" <Emoore@lsil.com>
Subject: Re: 2.4.25-rc1: Inconsistent ioctl symbol usage in
 drivers/message/fusion/mptctl.c
In-Reply-To: <2556.1076289485@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.58L.0402091026110.11598@logos.cnet>
References: <2556.1076289485@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Eric,

Can you please fix this up?

On Mon, 9 Feb 2004, Keith Owens wrote:

> 2.4.25-rc1 drivers/message/fusion/mptctl.c expects sys_ioctl,
> register_ioctl32_conversion and unregister_ioctl32_conversion to be
> exported symbols when MPT_CONFIG_COMPAT is defined.  That symbol is
> defined for __sparc_v9__, __x86_64__ and __ia64__.
>
> The symbols are not exported in ia64, mptctl.o gets unresolved symbols
> when it is a module on ia64.
>
> x64_64 exports register_ioctl32_conversion and unregister_ioctl32_conversion,
> but not sys_ioctl.
