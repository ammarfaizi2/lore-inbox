Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266244AbUHYOll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266244AbUHYOll (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 10:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUHYOll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 10:41:41 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:30353
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S266244AbUHYOla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 10:41:30 -0400
Message-ID: <412CA518.7090109@bio.ifi.lmu.de>
Date: Wed, 25 Aug 2004 16:41:28 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Broadbent <markb@wetlettuce.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1: ip auto-config accepts wrong packages
References: <412C5E80.8050603@bio.ifi.lmu.de> <1093439062.25506.12.camel@mbpc.signal.qinetiq.com>
In-Reply-To: <1093439062.25506.12.camel@mbpc.signal.qinetiq.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Mark Broadbent wrote:
> On Wed, 2004-08-25 at 10:40, Frank Steiner wrote:

> Try enabling the debug messaging in the ipconfig code.  Edit the file
> net/ipv4/ipconfig.c just below the #include's and change the line 
> 
> #undef IPCONFIG_DEBUG
> 
> to
> 
> #define IPCONFIG_DEBUG
> 
> and rebuild.  Post the outputs from both machines when you see this
> effect again.

the output is exactly the same on both machines! On the one machine that
went through (because it got the IP first) I got the output from dmesg,
printed it and compared it to the both boot screens. And they are really
identical.

I didn't see any option (or "extension") that contains the mac address.
Could that be the problem? Do I have to tell the server that the mac
address must be in the request-list?

cu,
Frank



IP-Config: Entered.
IP-Config: eth0 UP (able=1, xid=07196018)
Sending DHCP requests .DHCP: Sending message type 1
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
DHCP: Got message type 2
DHCP: Offered address 141.84.1.168 by server 141.84.1.132
DHCP/BOOTP: Got extension 53: 02
DHCP/BOOTP: Got extension 54: 8d 54 01 84
DHCP/BOOTP: Got extension 51: 00 00 1c 20
DHCP/BOOTP: Got extension 1: ff ff ff 80
DHCP/BOOTP: Got extension 3: 8d 54 01 82
DHCP/BOOTP: Got extension 6: 81 bb d6 87
DHCP/BOOTP: Got extension 12: 72 61 64 6f
DHCP/BOOTP: Got extension 15: 62 69 6f 2e 69 66 69 2e 6c 6d 75 2e 64 65
DHCP/BOOTP: Got extension 17: 2f
DHCP/BOOTP: Got extension 28: 8d 54 01 ff
DHCP/BOOTP: Got extension 208: f1 00 74 7e
DHCP/BOOTP: Got extension 209: 70 78 65 6c 69 6e 75 78 2e 63 66 67 2e 72 61 64 6f
DHCP/BOOTP: Got extension 210: 68 6f 73 74 73 2f
,DHCP: Sending message type 3
DHCP: Got message type 5
DHCP/BOOTP: Got extension 53: 05
DHCP/BOOTP: Got extension 54: 8d 54 01 84
DHCP/BOOTP: Got extension 51: 00 00 1c 20
DHCP/BOOTP: Got extension 1: ff ff ff 80
DHCP/BOOTP: Got extension 3: 8d 54 01 82
DHCP/BOOTP: Got extension 6: 81 bb d6 87
DHCP/BOOTP: Got extension 12: 72 61 64 6f
DHCP/BOOTP: Got extension 15: 62 69 6f 2e 69 66 69 2e 6c 6d 75 2e 64 65
DHCP/BOOTP: Got extension 17: 2f
DHCP/BOOTP: Got extension 28: 8d 54 01 ff
DHCP/BOOTP: Got extension 208: f1 00 74 7e
DHCP/BOOTP: Got extension 209: 70 78 65 6c 69 6e 75 78 2e 63 66 67 2e 72 61 64 6f
DHCP/BOOTP: Got extension 210: 68 6f 73 74 73 2f
  OK
IP-Config: Got DHCP answer from xxx.xxx.1.132, my address is xxx.xxx.1.168
IP-Config: Complete:
       device=eth0, addr=xxx.xxx.1.168, mask=255.255.255.128, gw=xxx.xxx.1.130,
      host=rado, domain=xxx nis-domain=(none),
      bootserver=xxx.xxx.1.132, rootserver=xxx.xxx.1.132, rootpath=/



-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

