Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267449AbSLRXXW>; Wed, 18 Dec 2002 18:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267450AbSLRXXV>; Wed, 18 Dec 2002 18:23:21 -0500
Received: from twister.ispgateway.de ([62.67.200.3]:43786 "HELO
	twister.ispgateway.de") by vger.kernel.org with SMTP
	id <S267449AbSLRXXT>; Wed, 18 Dec 2002 18:23:19 -0500
Message-ID: <3E010531.8020101@mailsammler.de>
Date: Thu, 19 Dec 2002 00:30:57 +0100
From: Torben Frey <kernel@mailsammler.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Horrible drive performance under concurrent i/o jobs (dlh problem?)
References: <1040245847.3e00e457a4d66@kolivas.net> <3E00F3B4.7050209@mailsammler.de> <3E00F894.BDAB4E05@digeo.com>
In-Reply-To: <3E00F894.BDAB4E05@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, hi Con,

> Here's a diff against base 2.4.20.  It may be a little out of date
> wrt Andrea's latest but it should tell us if we're looking in the
> right place.
Ok, I did not run the complete 2.4.20aa1 kernel yet since I am not sure 
if it is intended to be used, but I applied your patch, Andrew (thanks 
for mailing it). It still does not fix the problem. One job doing much 
I/O starts with about 80% CPU but then drops down to about 30% in the 
first 40 seconds. Load goes from 0.00 to 2.4 within that time.

And I can see bdflush and my process marked with "D" in the process list.

Catting the device to /dev/null only made it worse :-(

Creating a 1GB file using dd takes about 1 minute compared to 16 seconds 
without other jobs running.

Do you think it could be a ReiserFS problem on a RAID? Do you know of 
anything else I could try? Sorry, but my knowledge doesn't reach that far.

TIA,
Torben

