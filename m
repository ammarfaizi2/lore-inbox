Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWBYGZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWBYGZU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 01:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWBYGZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 01:25:20 -0500
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:14560 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932258AbWBYGZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 01:25:19 -0500
Date: Sat, 25 Feb 2006 01:22:17 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] x86_64: don't use early_printk() during memory
  init
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Message-ID: <200602250124_MC3-1-B940-4AEE@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200602250526.06389.ak@suse.de>

On Sat, 25 Feb 2006 at 05:26:05 +0100, Andi Kleen wrote:

> > printk is working by the time this memory init message prints.
> > As it stands, output jumps to the top of the screen and prints
> > this message, then back to normal boot messages, overwriting
> > a line at the top.
> 
> Using of early_printk here was intentional because it needs
> much less infrastructure than printk and is pretty good proof
> that the kernel at least started.

 Well it made me think something had gone horribly wrong and was
scribbling over video memory.  Especially since it left debris
at the end of the line... and you don't want to fix that either.

-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert

