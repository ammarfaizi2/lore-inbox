Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135881AbRDTLtU>; Fri, 20 Apr 2001 07:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135880AbRDTLtK>; Fri, 20 Apr 2001 07:49:10 -0400
Received: from fe000.worldonline.dk ([212.54.64.194]:7 "HELO
	fe000.worldonline.dk") by vger.kernel.org with SMTP
	id <S135879AbRDTLtF>; Fri, 20 Apr 2001 07:49:05 -0400
Message-ID: <3AE02DE1.C8C05C6D@eisenstein.dk>
Date: Fri, 20 Apr 2001 12:38:57 +0000
From: Jesper Juhl <juhl@eisenstein.dk>
Organization: Eisenstein
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: npunmia@hss.hns.com
CC: linux-kernel@vger.kernel.org
Subject: Re: RTC !
In-Reply-To: <65256A34.003CDC69.00@sandesh.hss.hns.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

npunmia@hss.hns.com wrote:

> Hi,
>
> When i compiled the following program , (taken from
> /usr/src/linux/Documentation/rtc.txt )
>
> (See attached file: rtc2.c)
>
> it gave me the following error:
>
> [root@msatuts1 timer1]#  gcc -s -Wall -Wstrict-prototypes rtc2.c -o rtc2
> In file included from rtc2.c:17:
> /usr/include/linux/mc146818rtc.h:29: parse error before `rtc_lock'
> /usr/include/linux/mc146818rtc.h:29: warning: data definition has no type or
> storage class
> rtc2.c:25: warning: return type of `main' is not `int'
> [root@msatuts1 timer1]#
>
>  Is this a bug?Can anyone tell me how to remove this parse error ?

It works fine for me using a 2.2.16 kernel and egcs-2.91.66 (see below)...


bash-2.04$ gcc -s -Wall -Wstrict-prototypes rtc2.c -o rtc2
rtc2.c:24: warning: return type of `main' is not `int'
bash-2.04$ ./rtc2

                        RTC Driver Test Example.

Counting 5 update (1/sec) interrupts from reading /dev/rtc: 1 2 3 4 5
Again, from using select(2) on /dev/rtc: 1 2 3 4 5

Current RTC date/time is 20-4-2001, 12:34:01.
Alarm time now set to 12:34:06.
Waiting 5 seconds for alarm... okay. Alarm rang.

Periodic IRQ rate was 1024Hz.
Counting 20 interrupts at:
2Hz:     1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
4Hz:     1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
8Hz:     1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
16Hz:    1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
32Hz:    1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
64Hz:    1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20

                         *** Test complete ***

Typing "cat /proc/interrupts" will show 131 more events on IRQ 8.

bash-2.04$


Regards,
Jesper Juhl
juhl@eisenstein.dk


