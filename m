Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272323AbRH3QlN>; Thu, 30 Aug 2001 12:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272324AbRH3QlD>; Thu, 30 Aug 2001 12:41:03 -0400
Received: from h157s242a129n47.user.nortelnetworks.com ([47.129.242.157]:20617
	"EHLO zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S272323AbRH3Qky>; Thu, 30 Aug 2001 12:40:54 -0400
Message-ID: <3B8E6CA3.6F5F6735@nortelnetworks.com>
Date: Thu, 30 Aug 2001 12:41:07 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Roman Zippel <zippel@linux-m68k.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        David Lang <david.lang@digitalinsight.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <Pine.LNX.4.33.0108300909560.7973-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> For example, let's look at this perfectly natural code:
> 
>         static int unix_mkname(struct sockaddr_un * sunaddr, int len, unsigned *hashp)
>         {
>                 if (len <= sizeof(short) || len > sizeof(*sunaddr))
>                         return -EINVAL;
>                 ...
> 
> Would you agree that the above is _good_ code, and code that makes
> perfect sense, and code that does exactly the right thing in testing its
> arguments?

Wouldn't it have made more sense to make the 'len' parameter an unsigned int? 
Presumably we can't have a negative length for a name.  In this case the
warnings should just go away, no?


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
