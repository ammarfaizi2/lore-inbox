Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270391AbTHQQxh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 12:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270383AbTHQQxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 12:53:37 -0400
Received: from user-0cal2fl.cable.mindspring.com ([24.170.137.245]:3200 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id S270378AbTHQQxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 12:53:33 -0400
Message-ID: <3F3FB275.3090601@davehollis.com>
Date: Sun, 17 Aug 2003 12:51:01 -0400
From: David T Hollis <dhollis@davehollis.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Carlos Velasco <carlosev@newipnet.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lamont Granquist <lamont@scriptkiddie.org>,
       Bill Davidsen <davidsen@tmr.com>, "David S. Miller" <davem@redhat.com>,
       bloemsaa@xs4all.nl, Marcelo Tosatti <marcelo@conectiva.com.br>,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
References: <Pine.LNX.3.96.1030728222606.21100A-100000@gatekeeper.tmr.com> <20030728213933.F81299@coredump.scriptkiddie.org> <200308171509570955.003E4FEC@192.168.128.16> <200308171516090038.0043F977@192.168.128.16> <1061127715.21885.35.camel@dhcp23.swansea.linux.org.uk> <200308171555280781.0067FB36@192.168.128.16> <1061134091.21886.40.camel@dhcp23.swansea.linux.org.uk> <200308171759540391.00AA8CAB@192.168.128.16>
In-Reply-To: <200308171759540391.00AA8CAB@192.168.128.16>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Velasco wrote:

>On 17/08/2003 at 16:28 Alan Cox wrote:
>
>  
>
>>Linux doesn't issue "bad" requests. Linux will reply when it is
>>asked for an address that it owns, as per RFC826, unless you chose
>>to change the behaviour with things like arpfilter.
>>    
>>
>
>We are not talking about ARP Replies, we are talking about ARP
>Requests.
>You can see the Richard post here, same issue I reported several weeks
>ago:
>http://marc.theaimsgroup.com/?l=linux-net&m=106094924813337&w=2
>
>==
>	On eth0, we see:
>
>11:23:55.650514 0:4:75:ca:c4:ef Broadcast arp 42: arp who-has
>10.10.10.1
>tell 212.xxx.yyy.9
>==
>
>Linux is sending an ARP Request to a LAN where the source IP address of
>the packet has not any sense in that IP network.
>And, at least, 2 RFCs are stating that other devices should not reply
>to this packet. Currently know Cisco, Foundry; possibly others, and
>possibly others coming as ARP storms are not desired.
>
>Regards,
>Carlos Velasco
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
Check out: http://www.linuxvirtualserver.org/docs/arp.html.  I 
understand the problem you're talking about.  It's not a 'bug', it's a 
feature!  You need to use the hidden interface approach to have the back 
end system not broadcast it's MAC for the virtual IP.

