Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289250AbSANOtz>; Mon, 14 Jan 2002 09:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289252AbSANOtq>; Mon, 14 Jan 2002 09:49:46 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:44722 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S289250AbSANOtl>;
	Mon, 14 Jan 2002 09:49:41 -0500
Message-ID: <3C42EF81.5060607@dplanet.ch>
Date: Mon, 14 Jan 2002 15:47:29 +0100
From: Giacomo Catenazzi <cate@dplanet.ch>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>
CC: "'Giacomo Catenazzi'" <cate@debian.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA hardware discovery -- the elegant solution
In-Reply-To: <F50839283B51D211BC300008C7A4D63F0C1075A2@eukgunt002.uk.eu.ericsson.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jan 2002 14:49:40.0325 (UTC) FILETIME=[B1EA7150:01C19D0A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Michael Lazarou (ETL) wrote:


>>Not a problem. Autoconfiguration is made to help configuring
>>the kernel, before to compile it. So you need a linux working
>>machine (actually you can cross-compile).
>>
>>Our task is to allow user to compile a kernel, with the
>>needed drivers, without the non used drivers.
>>
> 
> OK, well I guess I am a little confused.
> 
> If I hit an autoconfigurator button then I would expect a kernel that
> will boot and know everything there is to know about my machine.


Actually there is no yet 'autoconfigurator button'.
I recommend to run a std configuration tool and to check
the configuration before the kernel build phase.

> Without probing the hardware how will the autoconfigurator cope with 
> the hardware changing underneath it?


We probe the hardware (but in a soft manner).
Better: we probe nothing, we ask kernel to give us the results
of already done kernel probes. Thus we never hang, we never crash
machine, no 10-15 reboots to install a new kernel.
The good news: this is nearly enought.

Linux is magic: it can do infinite loops in 5 sec, but also
it can configure automatically a new kernel without real hardware
probes!.

	giacomo

