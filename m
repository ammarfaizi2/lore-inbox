Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274477AbRITN3h>; Thu, 20 Sep 2001 09:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274479AbRITN31>; Thu, 20 Sep 2001 09:29:27 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:24845 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S274477AbRITN3K>;
	Thu, 20 Sep 2001 09:29:10 -0400
Date: Thu, 20 Sep 2001 10:29:15 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix page aging (2.4.9-ac12)
In-Reply-To: <20010920132504Z16271-2758+295@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0109201028121.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2001, Daniel Phillips wrote:

>      static inline void age_page_down(struct page *page)
>      {
>  	page->age = max((int) (age - PAGE_AGE_DECL), 0);
>      }

While we're at it:   ;)

static inline void age_page_down(struct page * page)
{
	page->age -= min (PAGE_AGE_DECL, page->age);
}

cheers,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

