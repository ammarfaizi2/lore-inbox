Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbSLZBLw>; Wed, 25 Dec 2002 20:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbSLZBLw>; Wed, 25 Dec 2002 20:11:52 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:55210 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S261624AbSLZBLu>; Wed, 25 Dec 2002 20:11:50 -0500
Message-ID: <20021226000308.31344.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: akpm@digeo.com, vda@port.imtp.ilyichevsk.odessa.ua, conma@kolivas.net,
       riel@conectiva.com.br
Cc: ciarrocchi@linuxmail.org, linux-kernel@vger.kernel.org
Date: Thu, 26 Dec 2002 08:03:08 +0800
Subject: Re: Poor performance with 2.5.52, load and process in D state
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew/Rik/Con/all

Andrew, I promised you to run a few tests
using osdb (www.osdb.org with 40M of data)against both 
2.4.19 and 2.5.52 booting the kernel with the 
mem=XXM paramter.

I also played with the /proc/sys/vm/swappiness
parameter, I've ran all the tests with the standard
swappiness value (60), with 80 and 100.

100 means the 2.4 behaviour, isn't it ?

Looking at the results it seems that the "standard" 
value is too low, probably 80 is the best one.
What do you think ?

There is no a big difference in the Time results
between 80 and 100 but looking at the top output
while I was running the tests I saw a big difference
in the swap usage.

Con, could you please run the contest test against
2.5.52 or .53 platying with the swappines parameter ?

Below the results of my test, please let me know if 
you want I run more tests or if you need more information. 

Ciao,
            Paolo
            
-- By Memory Size --
Kernel	Memory	Swappiness	Time
2.4.19	24	x		3371.98 seconds (0:56:11.98)
2.5.52	24	60		4585.03 seconds (1:16:25.03)
2.5.52	24	80		4285.98 seconds (1:11:25.98)
2.5.52	24	100		3633.64 seconds (1:00:33.64)

2.4.19	40	x		809.39 seconds  (0:13:29.39)
2.5.52	40	60		3771.85 seconds (1:02:51.85)
2.5.52	40	80		3342.82 seconds (0:55:42.82)
2.5.52	40	100		855.22 seconds  (0:14:15.22)

2.4.19	64	x		796.03 seconds  (0:13:16.03)
2.5.52	64	60		840.41 seconds  (0:14:00.41)
2.5.52	64	80		828.59 seconds  (0:13:48.59)
2.5.52	64	100		833.92 seconds  (0:13:53.92)

2.4.19	80	x		790.80 seconds  (0:13:10.80)
2.5.52	80	60		788.65 seconds  (0:13:08.65)
2.5.52	80	80		790.54 seconds  (0:13:10.54)
2.5.52	80	100		793.79 seconds  (0:13:13.79)

2.5.52	96	60		779.54 seconds  (0:12:59.54)
2.5.52	96	80		782.86 seconds  (0:13:02.86)
2.5.52	96	100		778.81 seconds  (0:12:58.81)

2.4.19	all	x		778.65 seconds  (0:12:58.65)
2.5.52	all	60		768.98 seconds  (0:12:48.98)
2.5.52	all	80		770.43 seconds  (0:12:50.43)
2.5.52	all	100		771.76 seconds  (0:12:51.76)

-- By kernel version --
2.4.19  24      x               3371.98 seconds (0:56:11.98)
2.4.19  40      x               809.39 seconds  (0:13:29.39)
2.4.19  64      x               796.03 seconds  (0:13:16.03)
2.4.19  80      x               790.80 seconds  (0:13:10.80)
2.4.19  all     x               778.65 seconds  (0:12:58.65)

2.5.52  24      60              4585.03 seconds (1:16:25.03)
2.5.52  40      60              3771.85 seconds (1:02:51.85)
2.5.52  64      60              840.41 seconds  (0:14:00.41)
2.5.52  80      60              788.65 seconds  (0:13:08.65)
2.5.52  96      60              779.54 seconds  (0:12:59.54)
2.5.52  all     60              768.98 seconds  (0:12:48.98)

2.5.52  24      80              4285.98 seconds (1:11:25.98)
2.5.52  40      80              3342.82 seconds (0:55:42.82)
2.5.52  64      80              828.59 seconds  (0:13:48.59)
2.5.52  80      80              790.54 seconds  (0:13:10.54)
2.5.52	96	80		782.86 seconds  (0:13:02.86)
2.5.52  all     80              770.43 seconds  (0:12:50.43)

2.5.52  24      100             3633.64 seconds (1:00:33.64)
2.5.52  40      100             855.22 seconds  (0:14:15.22)
2.5.52	64	100		833.92 seconds  (0:13:53.92)
2.5.52  80      100             793.79 seconds  (0:13:13.79)
2.5.52  96      100             778.81 seconds  (0:12:58.81)
2.5.52  all     100             771.76 seconds  (0:12:51.76)



-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze
