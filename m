Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbVAZOEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbVAZOEH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 09:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262302AbVAZOEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 09:04:07 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:22810 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262303AbVAZODb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 09:03:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=uruaREUAWwzAfNvmADvIjryTyTCqlVvAeYBfFqzw8qQX68GZEP5bqJrhlVTNR0rsKY427mdVNbnIFukCDsMWjPhPehjB1ofQr4HcpcvluY65dqspgcmubH1jqpvkfcqjXS0NyhHu3hqfs+vIuA2quvqSt2fUj9q26hwhkhRLSf4=
Message-ID: <3f250c7105012606031652961d@mail.gmail.com>
Date: Wed, 26 Jan 2005 10:03:28 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: User space out of memory approach
Cc: tglx@linutronix.de, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Edjard Souza Mota <edjard@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050126004901.GD7587@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <4d6522b9050110144017d0c075@mail.gmail.com>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <20050111083837.GE26799@dualathlon.random>
	 <3f250c71050121132713a145e3@mail.gmail.com>
	 <3f250c7105012113455e986ca8@mail.gmail.com>
	 <20050122033219.GG11112@dualathlon.random>
	 <3f250c7105012513136ae2587e@mail.gmail.com>
	 <1106689179.4538.22.camel@tglx.tec.linutronix.de>
	 <3f250c71050125161175234ef9@mail.gmail.com>
	 <20050126004901.GD7587@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

On Wed, 26 Jan 2005 01:49:01 +0100, Andrea Arcangeli <andrea@suse.de> wrote:
> On Tue, Jan 25, 2005 at 08:11:19PM -0400, Mauricio Lin wrote:
> > Sometimes the first application to be killed is XFree. AFAIK the
> 
> This makes more sense now. You need somebody trapping sigterm in order
> to lockup and X sure traps it to recover the text console.
> 
> Can you replace this:
> 
>         if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
>                 force_sig(SIGTERM, p);
>         } else {
>                 force_sig(SIGKILL, p);
>         }
> 
> with this?

OK, let me test it. If I get some news, I will let you know.

> 
>         force_sig(SIGKILL, p);
> 
> in mm/oom_kill.c.

BR,

Mauricio Lin.
