Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267621AbTAXJ4X>; Fri, 24 Jan 2003 04:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267622AbTAXJ4X>; Fri, 24 Jan 2003 04:56:23 -0500
Received: from pluvier.ens-lyon.fr ([140.77.167.5]:35978 "EHLO
	mailhost.ens-lyon.fr") by vger.kernel.org with ESMTP
	id <S267621AbTAXJ4W>; Fri, 24 Jan 2003 04:56:22 -0500
Date: Fri, 24 Jan 2003 11:05:30 +0100
From: Brice Goglin <bgoglin@ens-lyon.fr>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: AH transformation broken since 2.5.56
Message-ID: <20030124100530.GA32263@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: David S. Miller (davem@redhat.com)
> Date: Thu Jan 23 2003 - 21:21:14 EST
>
>   From: Brice Goglin <bgoglin@ens-lyon.fr>
>   Date: Wed, 22 Jan 2003 14:31:07 +0100
> 
>   Support for IPsec AH in net/ipv4/ah.c is broken since 2.5.56
>
>   (still broken in 2.5.59).
>   I tried with CONFIG_INET_AH=y and m, I got the same error :
>
> You have to enable CONFIG_CRYPTO_HMAC if you want to enable
> CONFIG_INET_AH

Ok, thanks.
I just saw that net/ipv4/Kconfig make CONFIG_INET_AH depend on
CONFIG_CRYPTO_HMAC.

My problem was based on the fact that you can disable
CONFIG_CRYPTO_HMAC by disabling CONFIG_CRYPTO. But this will not
disable CONFIG_INET_AH.

Shouldn't there be a fix in dependencies between CONFIG_CRYPTO
and CONFIG_CRYPTO_HMAC, or between CONFIG_INET_AH and
CONFIG_CRYPTO ?

Regards

Brice Goglin
============
Ph.D Student
Laboratoire de l'Informatique du Parallélisme
ENS Lyon
France
