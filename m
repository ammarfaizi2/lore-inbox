Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbTLSM5S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 07:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbTLSM4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 07:56:10 -0500
Received: from user-12hcje4.cable.mindspring.com ([69.22.77.196]:59799 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id S263303AbTLSMqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 07:46:11 -0500
Subject: Re: VLAN switching in linux kernel...
From: David T Hollis <dhollis@davehollis.com>
To: Madhavi <madhavis@sasken.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0312191736510.17109-100000@pcz-madhavis.sasken.com>
References: <Pine.LNX.4.33.0312191736510.17109-100000@pcz-madhavis.sasken.com>
Content-Type: text/plain
Message-Id: <1071837956.8316.1.camel@dhollis-lnx.kpmg.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Fri, 19 Dec 2003 07:45:58 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-12-19 at 07:13, Madhavi wrote:
> Hi,
> 
> I have a doubt regarding the VLAN operation of the Standard Linux kernel
> (linux-2.4.20).
> 
> My network setup is something like this:
> 
> ---+---------------+------ VLAN ID 200
>    |eth0.200       |eth0.200
> +------+       +------+
> |  HA  |       |Router|
> +------+       +------+
>                    |eth1.300
> -----------+-------------- VLAN ID 300
>            |eth0.300
>         +------+
>         |  HB  |
>         +------+
> 
> When I send ping packets from HA to HB over the interface eth0.200, is
> possible for the Router (using linux-2.4.20 with CONFIG_8021Q option) to
> switch packets from VLAN 200 to VLAN 300?
> 
> Is this VLAN switching functionality supported by the standard linux kernel?
> Is there some extra configuration, some patches or sources that can support
> this feature for linux?
> 
> I would be a great help to me if someone could answer this or give some
> pointers to this?
> 
> Thanks & Regards
> Madhavi.
> 

You would route between the two VLANs.  They are two different broadcast
domains, you need to route them at Layer 3.  HA would have a route or
default gw pointed at ROUTER which has IP forwarding turned on and you
should be able to hit HB.

