Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129712AbRB1JxY>; Wed, 28 Feb 2001 04:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129614AbRB1JxO>; Wed, 28 Feb 2001 04:53:14 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:60420 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129534AbRB1JxF>; Wed, 28 Feb 2001 04:53:05 -0500
Subject: Re: -ac6 mis-reports cpu clock
To: bradley_kernel@yahoo.com (bradley mclain)
Date: Wed, 28 Feb 2001 09:56:21 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010228062156.33159.qmail@web9204.mail.yahoo.com> from "bradley mclain" at Feb 27, 2001 10:21:56 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Y3LL-0005Kv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> here is an extract from dmesg from 2.4.2 and -ac6,
> showing a disparity in cpu clock speed..
> 
> -ac6 has inserted a line claiming my clock is 400Mhz
> (it is actually 533 -- and i believe my fsb is 133).
> 
> i don't think i compiled these two radically
> differently.  what could i have done wrong to cause
> this?  or has -ac6 introduced a bug of some sort?

ac6 reads the clock speed data from the CPU and also compares it with the
running clock speed. So it thinks you have a chip intended for a 100Mhz
bus. (multiplier 4 FSB 100).

There are two possible causes for that result

#1	You are running a 400/100 component at 533/133
#2	The bus clock tables for intel are subtly different to the ones
	we've managed to deduce so far (Its not properly documented)

Alan

