Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310916AbSCHSvt>; Fri, 8 Mar 2002 13:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310950AbSCHSvi>; Fri, 8 Mar 2002 13:51:38 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55046 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310916AbSCHSvc>; Fri, 8 Mar 2002 13:51:32 -0500
Message-ID: <3C89080D.8060503@zytor.com>
Date: Fri, 08 Mar 2002 10:50:53 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Terje Eggestad <terje.eggestad@scali.com>,
        Ben Greear <greearb@candelatech.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        george anzinger <george@mvista.com>
Subject: Re: gettimeofday() system call timing curiosity
In-Reply-To: <E16iz57-0002SW-00@the-village.bc.nu> <1015515815.4373.61.camel@pc-16.office.scali.no> <a68bo4$b18$1@cesium.transmeta.com> <20020308013222.B14779@kushida.apsleyroad.org> <3C88157E.5010106@zytor.com> <20020308015701.C14779@kushida.apsleyroad.org> <20020308183049.A18247@kushida.apsleyroad.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

> 
> On my laptop, the median of rdtsc+gettimeofday+rdtsc times is 470 cycles
> for most runs of 1000, but is occasionally 453 cycles.
> 


What that indicates to me is that 1000 is way too small of a sample. 
You're only talking a difference of 17,000 cycles, which could -- 
especially with cache effects -- easily be the time spent in an 
interrupt handler.

	-hpa



