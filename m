Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313125AbSFDOsG>; Tue, 4 Jun 2002 10:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSFDOsF>; Tue, 4 Jun 2002 10:48:05 -0400
Received: from web12706.mail.yahoo.com ([216.136.173.243]:33299 "HELO
	web12706.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S313113AbSFDOsE>; Tue, 4 Jun 2002 10:48:04 -0400
Message-ID: <20020604144804.33629.qmail@web12706.mail.yahoo.com>
Date: Tue, 4 Jun 2002 07:48:04 -0700 (PDT)
From: Hossein Mobahi <hmobahi@yahoo.com>
Subject: Race: SignalHandler() & sleep()
To: linux-c-programming@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

main()
{
    ....
    signal (SIGIO, signalhandler() ) ;
    ....
    sleep (65535) ;
    ....
}

signalhandler() { ... } 

Assume the frequency of IO events is faster than one
event per 65535 seconds. Therefore, let's consider
65535 as infinity (sleeping foreveR).
If a SIGIO arrives, main will get out of sleep and
continue running, but signalhandler will be invoked
too. I wanted to know if there is any order/priority
for sleep() in main, and signalhandler() to be called
first, or one of them is invoked first randomly (race
condition) ?

I myself ran the program many times and everytime
observed signalhandler responding first. But maybe it
is not a rule, and it was just my chance ?

Thnx for your comment !

--Hossein Mobahi


__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
