Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281945AbRKUSrs>; Wed, 21 Nov 2001 13:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281944AbRKUSri>; Wed, 21 Nov 2001 13:47:38 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:33008 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S281932AbRKUSrZ>; Wed, 21 Nov 2001 13:47:25 -0500
Message-ID: <3BFBF6A4.6F1472C6@mvista.com>
Date: Wed, 21 Nov 2001 10:47:00 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Memory allocation question
In-Reply-To: <E165uQj-0007V2-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > size chuncks.  Currently I am using kmalloc() to allocate a page at a
> > time.  I don't want to have to worry about mapping/unmapping etc.  I
> 
> Use get_free_page() to get page sized chunks

What about __get_free_page() ?  I don't need or want the clear page
(performance issues).

And then to return the page, free_page() ?

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
