Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131142AbRAaH74>; Wed, 31 Jan 2001 02:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131234AbRAaH7r>; Wed, 31 Jan 2001 02:59:47 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:46093 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S131142AbRAaH7i>; Wed, 31 Jan 2001 02:59:38 -0500
Message-ID: <3A77C502.4010504@mvista.com>
Date: Tue, 30 Jan 2001 23:55:46 -0800
From: george anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.12-20b i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Joe deBlaquiere <jadb@redhat.com>
CC: David Woodhouse <dwmw2@infradead.org>, yodaiken@fsmlabs.com,
        Andrew Morton <andrewm@uow.edu.au>, Nigel Gamble <nigel@nrg.org>,
        linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <3A75A70C.4050205@redhat.com>  <200101220150.UAA29623@renoir.op.net> <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>, <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>; <20010128061428.A21416@hq.fsmlabs.com> <3A742A79.6AF39EEE@uow.edu.au> <3A74462A.80804@redhat.com> <20010129084410.B32652@hq.fsmlabs.com> <30672.980867280@redhat.com> <3A76E155.2030905@redhat.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe deBlaquiere wrote:

~snip~

> The locical answer is run with HZ=10000 so you get 100us intervals, 
> right ;o). 

Lets not assume we need the overhead of HZ=10000 to get 100us 
alarm/timer resolution.  How about a timer that ticks when we need the 
next tick...

On systems with multiple hardware timers you could kick off a 
> single event at 200us, couldn't you? I've done that before with the 
> extra timer assigned exclusively to a resource. 

With the right hardware resource, one high res counter can give you all 
the various tick resolutions you need. BTDT on HPRT.

George

It's not a giant time 
> slice, but at least you feel like you're allowing something to happen, 
> right?
> 
>> 
>> -- 
>> dwmw2

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
