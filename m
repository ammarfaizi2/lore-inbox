Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266429AbTGJTgX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 15:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266430AbTGJTgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 15:36:23 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:39691 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S266429AbTGJTgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 15:36:21 -0400
Message-ID: <3F0DC518.3010301@kolumbus.fi>
Date: Thu, 10 Jul 2003 22:57:12 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?YOSHIFUJI_Hideaki_/_=3F=3F=3F=3F?= 
	<yoshfuji@linux-ipv6.org>
CC: cat@zip.com.au, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       pekkas@netcore.fi
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling b0rked
References: <20030710154302.GE1722@zip.com.au> <20030711.005542.04973601.yoshfuji@linux-ipv6.org>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 10.07.2003 22:52:21,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 10.07.2003 22:51:48,
	Serialize complete at 10.07.2003 22:51:48
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



But 3ffe:8001:000c:ffff::36 is _not_ subnet routers anycast address. Anyway, looks like a bug to me...


--Mika


YOSHIFUJI Hideaki / ???? wrote:

>In article <20030710154302.GE1722@zip.com.au> (at Fri, 11 Jul 2003 01:43:03 +1000), CaT <cat@zip.com.au> says:
>
>  
>
>>With 2.4.21-pre2 I can get a nice tunnel going over my ppp connection
>>and as such get ipv6 connectivity. I think went to 2.4.21 and then to
>>2.4.22-pre4 and bringing up the tunnel fails as follows:
>>    
>>
>:
>  
>
>>ip addr add 3ffe:8001:000c:ffff::37/127 dev sit1
>> ip route add ::/0 via 3ffe:8001:000c:ffff::36 
>>RTNETLINK answers: Invalid argument
>>    
>>
>
>This is not bug, but rather misconfiguration;
>you cannot use prefix::, which is mandatory subnet routers 
>anycast address, as unicast address.
>
>Thank you.
>
>  
>


