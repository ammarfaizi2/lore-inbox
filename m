Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbUKVKnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbUKVKnb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 05:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbUKVKmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 05:42:31 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:13464 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262038AbUKVKkW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 05:40:22 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 22 Nov 2004 11:29:33 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: var args in kernel?
Message-ID: <20041122102933.GG29305@bytesex>
References: <20041109074909.3f287966.akpm@osdl.org> <1100018489.7011.4.camel@lb.loomes.de> <20041109211107.GB5892@stusta.de> <1100037358.1519.6.camel@lb.loomes.de> <20041110082407.GA23090@bytesex> <1100085569.1591.6.camel@lb.loomes.de> <20041118165853.GA22216@bytesex> <419E689A.5000704@backtobasicsmgmt.com> <20041122094312.GC29305@bytesex> <20041122101646.GP10340@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122101646.GP10340@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You can call va_start on the same args list twice, both:
> [ ... ]
> and
> void foo (int x, ...)
> {
>   va_list ap;
>   va_start (ap, x);
> ...
>   va_end (ap);
>   va_start (ap, x);
> ...
>   va_end (ap);
> }
> are ok.

Fine, then my patch is ok, it does exactly this ;)

>  What you can't do is e.g.
>   va_list ap;
>   va_start (ap, x);
>   bar (x, ap);
>   bar (x, ap);
>   va_end (ap);

This is how the code looked before I fixed it.

Thanks,

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
