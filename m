Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313421AbSFXN5A>; Mon, 24 Jun 2002 09:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313492AbSFXN47>; Mon, 24 Jun 2002 09:56:59 -0400
Received: from smtp2.tivoli.com ([216.140.178.3]:30873 "HELO smtp2.tivoli.com")
	by vger.kernel.org with SMTP id <S313421AbSFXN45>;
	Mon, 24 Jun 2002 09:56:57 -0400
Message-ID: <3D172543.9070709@tiscalinet.it>
Date: Mon, 24 Jun 2002 15:57:23 +0200
From: "Salvatore D'Angelo" <dangelo.sasaman@tiscalinet.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020513 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: Chris McDonald <chris@cs.uwa.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: gettimeofday problem
References: <3D16DE83.3060409@tiscalinet.it> <200206240934.g5O9YL524660@budgie.cs.uwa.edu.au> <3D16F252.90309@tiscalinet.it> <20020624154620.P19520@mea-ext.zmailer.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2000000 call -> 189 times I found the problem (0.00945%)
On 20000000 call ->1956 found I found the problem (0.00978%)

Probably you're right my previous percentage is too high (the one above 
should be the correct one).

But do you think that this behaviour is normal?

Matti Aarnio wrote:

>On Mon, Jun 24, 2002 at 12:20:02PM +0200, Salvatore D'Angelo wrote:
>  
>
>>In this piece of code I convert seconds and microseconds in 
>>milliseconds. I think the problem is not in my code, in fact I wrote the 
>>following piece of code in Java, and it does not work too. In the for 
>>loop the 90% of times b > a while for 10% of times not.
>>
>>    
>>
>...
>  
>
>>                    long a = System.currentTimeMillis();
>>                    long b = System.currentTimeMillis();
>>                    if (a > b) {
>>                         System.out.println("Wrong!!!!!!!!!!!!!");
>>                    }
>>    
>>
>
>
>   So in 10% of the cases, two successive calls yield time
>   rolling BACK ?
>
>   I used  gettimeofday()  call, and compared the original data
>   from the code.
>
>   At a modern uniprocessor machine I never get anything except
>   monotonously increasing time (TSC is used in betwen timer ticks
>   to supply time increase.)   At a dual processor machine, on
>   occasion I do get SAME value twice.   I have never seen time
>   rolling backwards.
>
>   Uh..  correction:  216199245  0:-1  -- it did step backwards,
>   but only once within about 216 million gettimeofday() calls.
>   (I am running 2.4.19-pre8smp at the test box.)
>
>/Matti Aarnio
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


