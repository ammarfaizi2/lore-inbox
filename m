Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267411AbUIATZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267411AbUIATZt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 15:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267414AbUIATZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 15:25:49 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:64410 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267411AbUIATZq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 15:25:46 -0400
Date: Wed, 1 Sep 2004 21:27:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] kallsyms: speed up /proc/kallsyms
Message-ID: <20040901192755.GC7219@mars.ravnborg.org>
Mail-Followup-To: Paulo Marques <pmarques@grupopie.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
References: <4134DEF4.8090001@grupopie.com> <1094016277.17828.53.camel@bach> <4135AFBE.1000707@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4135AFBE.1000707@grupopie.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 12:17:18PM +0100, Paulo Marques wrote:
 
> So, moving forward...
> 
> A defconfig build produces 13743 symbols with a compressed name stream
> of ~130kB. (it is 240kB uncompressed, for the curious)
> 
> Adding a letter to each symbol would increase this by about 10%.
> 
> We can try 2 different approaches to minimize the impact of this:
> 
>  - have the letter inserted before the compression step. This way, the
>    table of the best tokens may have "tacpi_" instead of "acpi_" and
>    the compression would not suffer as much, except that the symbols
>    started with "Tacpi_" would suffer. Only real tests can show how
>    this would turn out.
> 
>  - build a "sections" table that groups together symbols with the same
>    letter. The table would say symbols that have addresses between
>    X and Y would have letter Z. This can go horribly wrong if there
>    are situations where completely different type letters appear
>    intermixed.
> 
> I think I'll try the first approach first and see how it goes. I'll
> post as soon as I got some numbers.

When you have made the split Rusty requested and implemented
the above could you please send patches to me. I will add them to
my kbuild queue.

Yes - I have acccepted your rationale why to keep the split
of functionality between kallsyms and the kernel.

	Sam
