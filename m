Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbUDSW5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbUDSW5U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 18:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbUDSW5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 18:57:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:11450 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261161AbUDSW5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 18:57:15 -0400
Date: Mon, 19 Apr 2004 15:59:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: drepper@redhat.com, manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-user signal pending and message queue limits
Message-Id: <20040419155927.3279f13c.akpm@osdl.org>
In-Reply-To: <20040419212810.GB10956@logos.cnet>
References: <20040419212810.GB10956@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> (forgot the subject on the first message)
> 
> Andrew, 
> 
> Here goes the signal pending & POSIX mqueue's per-uid limit patch. 
> 
> Initialization has been moved to include/asm-i386/resource.h, as you suggested.
> 
> The global mqueue limit has been increased to 256 (64 per user), and the global 
> signal pending limit to 4096 (1024 per user).
> 
> This has been well tested.
> 
> If you are OK with it for inclusion (-mm) I'll generate the arch-dependant
> changes for the other architectures.

yes, please.

>          { RLIM_INFINITY, RLIM_INFINITY },		\
> +	{    IR_SIGNALS,    IR_SIGNALS },		\
> +	{    IR_MSGQUEUE,  IR_MSGQUEUE },		\

What does "IR" stand for here?  Can a more meaningful abbreviation be chosen?


