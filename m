Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261332AbSJIIiA>; Wed, 9 Oct 2002 04:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261510AbSJIIiA>; Wed, 9 Oct 2002 04:38:00 -0400
Received: from packet.digeo.com ([12.110.80.53]:59646 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261332AbSJIIh7>;
	Wed, 9 Oct 2002 04:37:59 -0400
Message-ID: <3DA3EC37.3F6FC3E8@digeo.com>
Date: Wed, 09 Oct 2002 01:43:35 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.41 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Giuliano Pochini <pochini@shiny.it>
CC: Robert Love <rml@tech9.net>, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, Chris Wedgwood <cw@f00f.org>
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
References: <1034104637.29468.1483.camel@phantasy> <XFMail.20021009103325.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Oct 2002 08:43:36.0029 (UTC) FILETIME=[F4E1D8D0:01C26F6F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuliano Pochini wrote:
> 
> > The point of O_STREAMING is one change: drop pages in the pagecache
> > behind our current position, that are free-able, because we know we will
> > never want them.
> 
> Does it drop pages unconditionally ?

Yup.

>  What happens if I do a
> streaming_cat largedatabase > /dev/null while other processes
> are working on it ?

You'll make your database run really slowly.

> It's not a good thing to remove the whole
> cached data other apps are working on.
> 

Don't do that then ;)

Seriously, there are tons of ways of creating local performance
DoS'es of this form.  fsync is an excellent tool for that.
