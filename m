Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271344AbRHPMtK>; Thu, 16 Aug 2001 08:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271345AbRHPMtA>; Thu, 16 Aug 2001 08:49:00 -0400
Received: from chaos.analogic.com ([204.178.40.224]:20868 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S271344AbRHPMsn>; Thu, 16 Aug 2001 08:48:43 -0400
Date: Thu, 16 Aug 2001 08:48:43 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: ServeRAID For Linux <ipslinux@us.ibm.com>
cc: jes@trained-monkey.org, alan@redhat.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [patch] ips.c spin lock 64 bit issues
In-Reply-To: <OFB6726B6C.6282CC76-ON85256AAA.00434E7F@raleigh.ibm.com>
Message-ID: <Pine.LNX.3.95.1010816084145.8161A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2001, ServeRAID For Linux wrote:

> That's only the tip of the iceberg for the "variable casting" and other
> changes that are required to make the ips driver completely safe on IA64.
> I have made all the changes necessary and we are currently in test mode
> with the next release of ips ( Version 4.80.xx ), which will be completely
> 64-bit safe.  I hope to make it available to all sometime in September,
> when we have completed our testing with it on both 32 and 64 bit Linux.
> 

I don't think that "unsigned long" is the correct data type.

Isn't there a data type that means "the largest unsigned integer type
that fits into a register on the target..."? I was told that that's what
"size_t" means. If so, all the flags variables <everywhere> should be
changed to this type. If not, then somebody should define a "flags_t"
type. With the new 64-bit machines, this is going to bite over and
over again until something like this is done.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


