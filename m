Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318264AbSHDXTQ>; Sun, 4 Aug 2002 19:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318266AbSHDXTP>; Sun, 4 Aug 2002 19:19:15 -0400
Received: from jalon.able.es ([212.97.163.2]:58256 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S318264AbSHDXTP>;
	Sun, 4 Aug 2002 19:19:15 -0400
Date: Mon, 5 Aug 2002 01:19:21 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Just cosmethic but...
Message-ID: <20020804231921.GA5118@junk.cps.unizar.es>
References: <3D4DAC97.mailYI11WJXY@viadomus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3D4DAC97.mailYI11WJXY@viadomus.com>
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020805 DervishD wrote:
>     Hi all :)
> 
>     The output of 'cat /proc/meminfo' is ugly by today standards,
> since is very frequent having more than 99 Mb of RAM and the current
> meminfo just supports 8 digits before outputting ugly tabulations.
> 
>     So, how about raising that 8 digits to at least 10, thus allowing
> pretty tabulations up to 9 Gb of RAM?
> 

Why 10 ?
    unsigned long k32= ~0;
    unsigned long long k64 = ~0;
    printf("%d %lu\n",sizeof(k32)*8,k32);
    printf("%d %llu\n",sizeof(k64)*8,k64);

gives

32 4294967295
64 18446744073709551615

On a 64 bit box you could have 2^64 bytes.
Opps, and on a 32bit box you could have 16Gb of swap ?
1Tb is:
    unsigned long long k64 = 1ULL<<40;
64 1099511627776

13 digits (nice number ;))

Sorry, late at night here...

-- 
J.A. Magallon                           \                 Software is like sex:
junk.able.es                             \           It's better when it's free
Mandrake Linux release 9.0 (Cooker) for i586
Linux 2.4.19-jam0 (gcc 3.2 (Mandrake Linux 9.0 3.2-0.2mdk))
