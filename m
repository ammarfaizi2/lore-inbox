Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbVJJOkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVJJOkG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 10:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVJJOkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 10:40:06 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:42369 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750814AbVJJOkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 10:40:01 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [PATCH] mm - implement swap prefetching
Date: Tue, 11 Oct 2005 00:39:50 +1000
User-Agent: KMail/1.8.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ck list <ck@vds.kolivas.org>
References: <200510110023.02426.kernel@kolivas.org> <9a8748490510100735k3cabd1csdc2aa332f70f43d5@mail.gmail.com>
In-Reply-To: <9a8748490510100735k3cabd1csdc2aa332f70f43d5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510110039.50775.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Oct 2005 00:35, Jesper Juhl wrote:
> On 10/10/05, Con Kolivas <kernel@kolivas.org> wrote:
> > Andrew could you please consider this for -mm
> >
> > Small changes to the style after suggestions from Pekka Enberg (thanks),
> > and changed the default size of prefetch to gently increase with size of
> > ram. Functionally this is the same code as vm-swap_prefetch-15 and I
> > believe ready for a wider audience.
>
> +	  What this will do on workstations is slowly bring back applications
> +	  that have swapped out after memory intensive workloads back into
> +	  physical ram if you have free ram at a later stage and the machine
> +	  is relatively idle. This means that when you come back to your
> +	  computer after leaving it idle for a while, applications will come
> +	  to life faster. Note that your swap usage will appear to increase
> +	  but these are cached pages, can be dropped freely by the vm, and it
> +	  should stabilise around 50% swap usage.
> +
> +	  Desktop users will most likely want to say Y.
>
> How about a little note about the impact for server users as well?
> You recommend that desktop users enable this, but you don't give any
> recommendation for servers.

Your guess is as good as mine. I can easily demonstrate a benefit when using 
it with desktop workloads but a server? It's not expensive to run but I don't 
really know if it's advantageous either. If I had to take a guess, a server 
that had multiple user logins running applications would benefit, but 
database, web servers etc I doubt would benefit.

Cheers,
Con
