Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272058AbRH2UHu>; Wed, 29 Aug 2001 16:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272059AbRH2UHk>; Wed, 29 Aug 2001 16:07:40 -0400
Received: from h157s242a129n47.user.nortelnetworks.com ([47.129.242.157]:57340
	"EHLO zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S272058AbRH2UH1>; Wed, 29 Aug 2001 16:07:27 -0400
Message-ID: <3B8D4B6E.331966E0@nortelnetworks.com>
Date: Wed, 29 Aug 2001 16:07:10 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war -- I like this
In-Reply-To: <200108291911.f7TJBvX11490@wildsau.idv-edu.uni-linz.ac.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Rosmanith wrote:

> #define type_min(type,x,y) \
>         ({ type __x = (x), __y = (y); __x < __y ? __x: __y; })
> #define type_max(type,x,y) \
>         ({ type __x = (x), __y = (y); __x > __y ? __x: __y; })
> 
> #define min(x,y) type_min(typeof(x),x,y)
> #define max(x,y) type_max(typeof(x),x,y)
> 
> no _implicit_ cast and ...
> 
> > One of the arguments gets changed invisibly, and that is what kernel
> > developers are so upset about.  You don't really know which one without
> > thinking hard about it, and that is a source of many hard-to-find bugs.
> 
> ... joy, we would even know which one.

I think this makes a lot of sense.  The explicit version could be preferred, but
for the implicit version we at least know that what type will be used for it and
it won't immediately break things that are still using the old-style min/max.


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
