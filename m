Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030395AbWBAFYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030395AbWBAFYL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbWBAFYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:24:11 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:32900 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S1030387AbWBAFYK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:24:10 -0500
Date: Wed, 1 Feb 2006 15:24:07 +1000
From: David McCullough <davidm@snapgear.com>
To: Ronen Shitrit <rshitrit@marvell.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ocf-linux-20051110 - Asynchronous Crypto support for linux
Message-ID: <20060201052407.GA15607@beast>
References: <B9FFC3F97441D04093A504CEA31B7C4168581E@msilexch01.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B9FFC3F97441D04093A504CEA31B7C4168581E@msilexch01.marvell.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jivin Ronen Shitrit lays it down ...
> Hi

Apologies,  somehow I never replied to this :-(

> I want to use the OCF OpenSwan KLIPS,
> I can see that the openswan patch is very big,
> What exactly does this patch support:
>  Which encryption Alg does it support??

It will accelerate anything supported by your driver configuration
in OCF.  For most drivers this is DES/3DES/AES and MD5/SHA

>  Which Authentication Alg does it support??

MD5/SHA

>  I saw that part of the patch is for the kernel and part for the user??
>  Is there any readme describing this patch??

Only whats up at http://ocf-linux.sourceforge.net/.

The current version supports KLIPS and accelerates ESP and AH.

The use part of the patch allows pluto to use crypto/IKE acceleration
through OCF as well.  You can ditch the user changes completely and
still get almost all the benefits.

The kernel changes appear larger than they are,  this is mainly due to
moving code around to be asynchronous.  The code it self is still the
same and if you read the data packet flow it will look almost identical.

> Is there any working going on, for porting the OCF to the kernel IPsec??

Some people have mentioned playing with 26sec (netkey) and OCF but I do not
know if anyone has it completed or in a state others can play with.

I hope to start on it at some stage if no one gets there before me :-)

Cheers,
Davidm

> -----Original Message-----
> From: linux-crypto-owner@vger.kernel.org
> [mailto:linux-crypto-owner@vger.kernel.org] On Behalf Of David
> McCullough
> Sent: Thursday, November 10, 2005 2:37 PM
> To: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Subject: ocf-linux-20051110 - Asynchronous Crypto support for linux
> 
> 
> Hi all,
> 
> A new release of the ocf-linux package is up:
> 
> 	http://ocf-linux.sourceforge.net/
> 
> Mostly Openswan updates/cleanups and fixes in this release.
> 
> * Patch for the latest OpenSwan to utilise OCF for full IPSEC
>   ESP and AH processing.
> * Well tested on 2.4.31 and 2.6.14 with OpenSwan.
> * Simple single patch to add OCF to 2.4 or 2.6 kernels.
> * Fixed broken openssl speed test (Ronen Shitrit)
> 
> Cheers,
> Davidm

-- 
David McCullough, davidm@cyberguard.com.au, Custom Embedded Solutions + Security
Ph:+61 734352815 Fx:+61 738913630 http://www.uCdot.org http://www.cyberguard.com
