Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274018AbRISIHG>; Wed, 19 Sep 2001 04:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274020AbRISIG4>; Wed, 19 Sep 2001 04:06:56 -0400
Received: from denise.shiny.it ([194.20.232.1]:1747 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S274018AbRISIGq>;
	Wed, 19 Sep 2001 04:06:46 -0400
Message-ID: <XFMail.20010919100702.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <200109190320.f8J3KC3272695@saturn.cs.uml.edu>
Date: Wed, 19 Sep 2001 10:07:02 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Subject: Re: Strange ps line
Cc: linux-kernel@vger.kernel.org,
        <flavio@conectiva.com.br (Flavio Bruno Leitner)>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>> From "ps axuw":
>>> 
>>> USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
>>> httpd     5020  0.0  0.0     0    0 ?        Z    16:46   0:00 [getcod.cgi <defunct>]
>>> httpd     5022  0.0  0.0     0    0 ?        Z    16:46   0:00 [getcod.cgi <defunct>]
>>> httpd     5025  0.0  0.0 589505315 0 ?       ZL   16:46   0:00 [getcod.cgi <defunct>]
>>> httpd     5049  0.0  0.0     0    0 ?        Z    16:46   0:00 [getcod.cgi <defunct>]
>>> 
>>> That cgi doesn't lock memory and surely I don't have so much memory.
>> 
>> Look at http://www.erlenstar.demon.co.uk/unix/faq_2.html#SEC14
>> maybe this can help you. 
> 
> Yes and no. It might solve his zombie problem, but what about that
> outrageous VSZ and the locked memory? Useful info would be:
> 
> /proc/5025/status
> /proc/5025/stat

That strange line is extremely rare. Actually it's the first time I see it and
I was unable to reproduce. And since it's a zombie it just didn't live enough
to type "cat /proc/....". I think there is a race somewhere. I don't know if
it's dangerous of if it only accects /proc reads sometimes ?


Bye.
