Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261713AbSJDNoq>; Fri, 4 Oct 2002 09:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261719AbSJDNoq>; Fri, 4 Oct 2002 09:44:46 -0400
Received: from stingr.net ([212.193.32.15]:33809 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S261713AbSJDNoq>;
	Fri, 4 Oct 2002 09:44:46 -0400
Date: Fri, 4 Oct 2002 17:50:16 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Cc: linux.nics@intel.com, Andrey Nekrasov <andy@spylog.ru>
Subject: Re: NIC on Intel STL2 - bad work with eepro100 & e100
Message-ID: <20021004135016.GJ6318@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux.nics@intel.com,
	Andrey Nekrasov <andy@spylog.ru>
References: <20021004113128.GA31145@an.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20021004113128.GA31145@an.local>
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Andrey Nekrasov:
> 			Intel Server Board STL2.
>       Network: onboard NIC "Intel(R) 82559 single chip PCI LAN controller"

I have almost the same behavior here except that eepro100 works
without freezes. Maybe spylog servers' NIC load is much more higher
than mine :)

Intel support guys advised me to test both versions of e100 driver.

ftp://aiedownload.intel.com/df-support/2896/eng/e100-2.1.15.tar.gz
ftp://aiedownload.intel.com/df-support/2896/eng/e100-1.8.38.tar.gz

Unfortunately, I haven't tested it yet. My investigation shows that
the following fragment of e100_main.c code fails:

<code from="e100_hw_init">
     if (!e100_wait_exec_cmplx(bdp, 0, SCB_RUC_LOAD_BASE))
            return false;
</code>

we returning false here.

And I am stalled for now till the end of next week until the ACM ICPC
Qfinal is over :(

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
