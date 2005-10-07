Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbVJGFfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbVJGFfz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 01:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVJGFfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 01:35:55 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:32407 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S932242AbVJGFfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 01:35:55 -0400
Subject: Re: [PATCH] Free swap suspend from dependency on PageReserved
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4344F90C.9070001@yahoo.com.au>
References: <1128546263.10363.14.camel@localhost>
	 <4344F90C.9070001@yahoo.com.au>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1128663205.13507.23.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 07 Oct 2005 15:33:25 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick.

On Thu, 2005-10-06 at 20:14, Nick Piggin wrote:
> Nigel Cunningham wrote:
> > From: Nigel Cunningham <nigel@suspend2.net>
> > 
> > This patch removes the dependency that swap suspend currently has on
> > PageReserved. In the places where PageReserved is currently set and
> > cleared, we also set and clear PageNosave, and in swap suspend itself,
> > we only reference PageNosave. The ongoing effort at freeing PageReserved
> > thus achieves another step forward.
> > 
> 
> Any reason you can't use page_is_ram directly? I would rather you
> do this than moving swsusp specific flags out into the wider tree.
> The reason is that these flags now become just as hard to kill as
> PageReserved is.
> 
> You'll have to slightly modify i386's page_is_ram, because it
> appears that you'll actually want
> 
>    'page_is_ram(pfn) && !(bad_ppro && page_kills_ppro(pfn))'

Thanks for the suggestion!

I suppose we could do something like what you are suggesting. I'll take
a look. I'm not promising to do it immediately though - too busy trying
to finish off Suspend2 at the mo.

> Thanks, glad someone is looking into this!

Always glad to be of service!

Nigel

> Nick
-- 


