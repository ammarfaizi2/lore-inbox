Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLNXVX>; Thu, 14 Dec 2000 18:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129773AbQLNXVN>; Thu, 14 Dec 2000 18:21:13 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:20722 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129257AbQLNXVI>; Thu, 14 Dec 2000 18:21:08 -0500
Date: Thu, 14 Dec 2000 17:50:35 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: "David S. Miller" <davem@redhat.com>
cc: <ionut@cs.columbia.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: ip_defrag is broken (was: Re: test12 lockups -- need feedback)
In-Reply-To: <Pine.LNX.4.30.0012141619330.1107-100000@viper.haque.net>
Message-ID: <Pine.LNX.4.30.0012141746380.1220-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do the following....

sudo modprobe iptable_nat

Module                  Size  Used by
iptable_nat            17440   0 (unused)
ip_conntrack           19808   1 [iptable_nat]
ip_tables              12320   3 [iptable_nat]


Oops start flying by when I access via NFS.

If you need the actual Oops messages we're gonna have to get someone
who can setup a serial console.

On Thu, 14 Dec 2000, Mohammad A. Haque wrote:

> Just quick feedback.
>
> Test 1:
> 	Netfilter compiled into kernel. Netfilter configuration options
> 	as modules. Modules loaded. Using NFS, I got Oops (in fact I've
> 	never seen an Oops output infinitely before. Maybe it would have
> 	stopped if I waited.)
>
> Test 2:
> 	Netfilter compiled into kernel. Netfilter configuration options
> 	as modules. Modules _NOT_ loaded. Can use NFS just fine. Did a
> 	couple of 100 MB transfers w/o problems.
>
>
> I'll continue narrowing it down.

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
