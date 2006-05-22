Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWEVOOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWEVOOI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 10:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWEVOOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 10:14:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:37787 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750840AbWEVOOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 10:14:03 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [PATCH 5/6, 2nd try] reliable stack trace support (i386)
Date: Mon, 22 May 2006 16:13:56 +0200
User-Agent: KMail/1.9.1
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
References: <4471D660.76E4.0078.0@novell.com>
In-Reply-To: <4471D660.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200605221613.57000.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 May 2006 15:18, Jan Beulich wrote:
> These are the i386-specific pieces to enable reliable stack traces. This is
> going to be even more useful once CFI annotations get added to he assembly
> code, namely to entry.S.

Also obsolete with 6/6? 

> +#ifdef CONFIG_STACK_UNWIND
> +  . = ALIGN(4);
> +  .eh_frame : AT(ADDR(.eh_frame) - LOAD_OFFSET) {
> +	__start_unwind = .;
> +  	*(.eh_frame)
> +	__end_unwind = .;
> +  }
> +#endif

Shouldn't this be CONFIG_UNWIND_INFO?  Seems a bit unsymmetric to x86-64

I merged the patches all up for now. Thanks.

-Andi
