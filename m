Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVAYAEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVAYAEt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVAXXVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:21:53 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:26309 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261735AbVAXXDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 18:03:23 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: davidm@hpl.hp.com
Cc: bgerst@didntduck.org, Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: inter_module_get and __symbol_get 
In-reply-to: Your message of "Mon, 24 Jan 2005 14:58:29 -0800."
             <16885.32149.788747.550216@napali.hpl.hp.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Jan 2005 10:03:01 +1100
Message-ID: <31612.1106607781@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005 14:58:29 -0800, 
David Mosberger <davidm@napali.hpl.hp.com> wrote:
>>>>>> On Tue, 25 Jan 2005 09:54:36 +1100, Keith Owens <kaos@ocs.com.au> said:
>
>  Keith> Does DRM support this model?
>
>  Keith> * Start DRM without AGP.
>  Keith> * AGP is loaded.
>  Keith> * DRM continues but now using AGP.
>
>  Keith> If yes then it needs dynamic symbol resolution.
>
>I think it does, but I don't see any advantages to it (not on the
>machines I'm using, at least).  In fact, I'd rather have an explicit
>dependency on AGP.

No argument from me :).  I have always hated the dynamic resolution
model used by DRM/AGP and (originally) MTD.

I have a very dim and distant memory from about 6 years ago that
somebody wanted the ability to run DRM with and without AGP support.
IOW, the decision about whether to load AGP or not was left to the
user, instead of AGP always being automatically loaded by modprobe.
Again this comes down to static vs. dynamic symbol resolution.

