Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290312AbSA3SJq>; Wed, 30 Jan 2002 13:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290306AbSA3SId>; Wed, 30 Jan 2002 13:08:33 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:65420 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S290311AbSA3SHo>;
	Wed, 30 Jan 2002 13:07:44 -0500
Message-ID: <3C583655.6060707@acm.org>
Date: Wed, 30 Jan 2002 12:07:17 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: "Richard B. Johnson" <root@chaos.analogic.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: TCP/IP Speed
In-Reply-To: <Pine.LNX.4.44.0201301831120.5518-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>On Wed, 30 Jan 2002, Richard B. Johnson wrote:
>
>>But it's already connected.
>>
>>
>>         host:
>>         for (;;) {
>>            gettimeofday(...);
>>            write(s, buf, 64);
>>            read(s, buf, sizeof(buffer));
>>            gettimeofday(...);
>>         /* delay is 1.0 ms */
>>         }
>>         server is IPPORT_ECHO
>>
>
>You didn't make that explicit in your previous email, and anyway what kind 
>of resolution can you expect from gettimeofday...
>
Depending on the processor, gettimeofday has very high resolution.

If I remember correctly, the TCP stacks put in delays for small sends so 
they can pack multiple things together.  I think there are ways to work 
around this via some type of flush, but memory fails me on exactly how.

-Corey

