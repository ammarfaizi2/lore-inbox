Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbULRKv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbULRKv7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 05:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbULRKv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 05:51:59 -0500
Received: from mail.netshadow.at ([217.116.182.106]:10709 "EHLO
	skeletor.netshadow.at") by vger.kernel.org with ESMTP
	id S262089AbULRKv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 05:51:56 -0500
Message-ID: <41C40BCB.7020608@netshadow.at>
Date: Sat, 18 Dec 2004 11:51:55 +0100
From: Andreas Unterkircher <unki@netshadow.at>
User-Agent: Mozilla Thunderbird 1.0RC1 (Windows/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Charles-Henri Collin <charlie.collin@free.fr>
Subject: Re: ip=dhcp problem...
References: <41C40326.3070303@free.fr>
In-Reply-To: <41C40326.3070303@free.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think that the kernel take care about the nameservers during bootup.

On my debian system resolving is only working, after init takes control
over the system and the network scripts running the dhclient-script
which also sends an dhcp-request - and finally get the same ip - and
adds the nameservers into the resolv.conf.

regards,

Andreas


Charles-Henri Collin wrote:

> Hi,
>
> I've got the following problem with linux 2.6.8.1:
> I'm nfs-rooting a diskless client with kernel parameter ip=dhcp.
> My dhcpd.conf  has a "option domain-name-servers X.X.X.X;" statement 
> and "get-lease-hostnames true;"
> Now when the diskless clients boot, no name-server configured and they 
> cant resolv.
> dmesg gives me, for instance:
>
> IP Config: Complete:
>    device=eth0, addr=192.168.0.237, mask=255.255.255.0, gw=192.168.0.1,
>    host=clientFSB-237.fsb.net, domain=fsb.net, nis-domain=FSBnis,
>    boot-server=192.168.0.254, rootserver=92.168.0.254, rootpath=
>
> So as you can see, everything is almost set up, except a nameserver!
> Has anyone heard about that problem before? Are there any fixes?
>
> regards,
> C COLLIN
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

