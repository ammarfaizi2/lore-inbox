Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbVLXTqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbVLXTqZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 14:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVLXTqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 14:46:25 -0500
Received: from web50113.mail.yahoo.com ([206.190.39.150]:29043 "HELO
	web50113.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932136AbVLXTqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 14:46:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=VPwpcdXAZh/R7Y7ghkXi4qn95sSeBGhknvsWWTOjVN+eP8qwfvjkg5uEp74Nl6ybtHKebjLgLWhyEe7eP/sIor8QJzrhETyUJfhqKJz8pB/rV4GCTSeA9mrfJIv9f0UlFOyE/zpS6Gio+iwOVr2N1hQs2Zeucrxw4Q8rEiIMPgY=  ;
Message-ID: <20051224194621.73206.qmail@web50113.mail.yahoo.com>
Date: Sat, 24 Dec 2005 11:46:21 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: Machine check 2.6.13.3 dual opteron
To: Andy Stewart <andystewart@comcast.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43AD8631.1090605@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the Opteron Bank 4 value you gave, this decodes to:


Decoding MCE value as MCi_STATUS: 'b200000000070f0f'
Bit  63:    Valid error
Bit  61:    UNCORRECTED error
Bit  60:    MCA Error Reporting Enabled
Bit  57:    Process Context Corrupt
            HyperTransport Link Number= 0
            Extended Error Code = 0x7 - WatchDog error

BUS Error:
        Processor(generic)
        TimeOut(timed out)
        Memory Transaction Type(generic)
        Mem or IO(generic)
        Cache Level(generic)

You had an Uncorrectable Error. 
Since you did not post an address error, I assume that it did NOT report such. Therefore, because
of the WatchDog error, there might be an error between the CPU and memory.  There is a hardware
problem definitely.

CPU-Mem Controller
Even bad memory DIMM

doug thompson


--- Andy Stewart <andystewart@comcast.net> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> Hi everybody,
> 
> My machine locked up on me and I found this message on my serial
> console.  I have no idea how to decode its meaning - can you help?
> 
> CPU 0: Machine Check Exception:                4
> Bank 4: b200000000070f0f
> TSC 39619ee1e2187
> Kernel panic - not syncing: Machine check
> 
> My machine is a dual Opteron running the 2.6.13.3 kernel.  I'm not
> positive, but I think I can reproduce it.  Assuming that I can, what
> information would be helpful to debug the problem?
> 
> Please cc: me on the response as I am not subscribed to this mailing list.
> 
> Thanks!
> 
> Andy
> - --
> Andy Stewart, Founder
> Worcester Linux Users' Group
> Worcester, MA, USA
> http://www.wlug.org
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.5 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
> 
> iD8DBQFDrYYxHl0iXDssISsRAjONAJ9zoU0vSmikAkMqmQI2po0Jp9E83QCghO/M
> Zxq/FKaldR1hzyrJqiJ+sMg=
> =gdcL
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



"If you think Education is expensive, just try Ignorance"

"Don't tell people HOW to do things, tell them WHAT you
want and they will surprise you with their ingenuity."
                   Gen George Patton

