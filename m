Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262864AbULRLwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbULRLwt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 06:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbULRLwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 06:52:49 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.28]:9801 "EHLO smtp3.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262864AbULRLwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 06:52:43 -0500
Message-ID: <41C41A09.8040608@free.fr>
Date: Sat, 18 Dec 2004 12:52:41 +0100
From: Charles-Henri Collin <charlie.collin@free.fr>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ip=dhcp problem...
References: <41C40326.3070303@free.fr> <Pine.LNX.4.61.0412181159580.28067@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0412181159580.28067@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt a écrit :

>>I've got the following problem with linux 2.6.8.1:
>>I'm nfs-rooting a diskless client with kernel parameter ip=dhcp.
>>My dhcpd.conf  has a "option domain-name-servers X.X.X.X;" statement and
>>"get-lease-hostnames true;"
>>Now when the diskless clients boot, no name-server configured and they cant
>>resolv.
>>dmesg gives me, for instance:
>>    
>>
>
>What happens if you put
>	option domain-name-servers 192.168.222.1;
>in your dhcpd.conf, i.e. an IP number rather than a host?
>
>
>
>
>Jan Engelhardt
>  
>
i do put IP in this field (192.168.0.254) in fact, but this doesnt work.
i'm looking for a reason why it desnt work.. i've just setup:
#define  IPCONFIG_DEBUG
in linux/net/ipv4/ipconfig.c, and this is what i get at boottime:

DHCP:   Get message type 2
DHCP:   Offered address 192.168.0.237 by server 192.168.0.254
DHCP/BOOTP:    Got extension   53: 02
DHCP/BOOTP:    Got extension   54: c0 a8 00 fe
DHCP/BOOTP:    Got extension   51: 00 01 19 40
DHCP/BOOTP:    Got extension   1: ff ff ff 00
DHCP/BOOTP:    Got extension   3: c0 a8 00 fe
DHCP/BOOTP:    Got extension   12: 63 6c 69 65 6e 74 46 53 42 2d 32 33 
37 2e 66 73 62 2e 6e 65 74 00
DHCP/BOOTP:    Got extension   15: 66 73 62 2e 6e 65 74
DHCP/BOOTP:    Got extension   40: 46 53 42 6e 69 73
,DHCP:   sending message type 3
DHCP: Got message type 5
DHCP/BOOTP:    Got extension   53: 05
DHCP/BOOTP:    Got extension   54: c0 a8 00 fe
DHCP/BOOTP:    Got extension   51: 00 01 19 40
DHCP/BOOTP:    Got extension   1: ff ff ff 00
DHCP/BOOTP:    Got extension   3: c0 a8 00 fe
DHCP/BOOTP:    Got extension   12: 63 6c 69 65 6e 74 46 53 42 2d 32 33 
37 2e 66 73 62 2e 6e 65 74 00
DHCP/BOOTP:    Got extension   15: 66 73 62 2e 6e 65 74
DHCP/BOOTP:    Got extension   40: 46 53 42 6e 69 73

Extension 6 is the nameserver (see config.c for more details) and it is 
set as you can see. that is strange....
i'm looking for more hints. hope this will help.
regards,

C COLLIN


