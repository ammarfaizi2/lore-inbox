Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271905AbRHVAtO>; Tue, 21 Aug 2001 20:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271907AbRHVAtE>; Tue, 21 Aug 2001 20:49:04 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:19474 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271905AbRHVAsy>;
	Tue, 21 Aug 2001 20:48:54 -0400
Date: Tue, 21 Aug 2001 21:48:15 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory Problem in 2.4.9 ?
In-Reply-To: <20010822003706Z16145-32383+770@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0108212146470.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001, Daniel Phillips wrote:

> --- ../2.4.9.clean/mm/filemap.c	Thu Aug 16 14:12:07 2001
> +++ ./mm/filemap.c	Wed Aug 22 01:11:44 2001
> @@ -980,7 +980,7 @@
>  static inline void check_used_once (struct page *page)
>  {
>  	if (!PageActive(page)) {
> -		if (page->age)
> +		if (page->age > 8)
>  			activate_page(page);
>  		else {
>  			page->age = PAGE_AGE_START;

This makes absolutely no sense since you'll never set the
page age higher than PAGE_AGE_START until the is actually
on the active list.

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

