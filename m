Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267916AbUHPTu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267916AbUHPTu2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 15:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267920AbUHPTu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 15:50:27 -0400
Received: from mail.tmr.com ([216.238.38.203]:37900 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S267916AbUHPTuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 15:50:25 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: BitTorrent and iptables (was: Can not read UDF CD)
Date: Mon, 16 Aug 2004 15:50:33 -0400
Organization: TMR Associates, Inc
Message-ID: <cfr2qh$8lf$1@gatekeeper.tmr.com>
References: <cfgjk6$gbi$1@gatekeeper.tmr.com><cfgjk6$gbi$1@gatekeeper.tmr.com> <200408131314.02352.jk-lkml@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1092685458 8879 192.168.12.100 (16 Aug 2004 19:44:18 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <200408131314.02352.jk-lkml@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Knutar wrote:
> On Thursday 12 August 2004 23:33, Bill Davidsen wrote:
> 
> 
>>I used torrent to pull something the other day, and while I could pull, 
>>no one could connect to get data from me. I have my iptables set to 
>>ESTABLISHED,RELATED so iptables may not know about torrent.
> 
> 
> You probably need to explicitly ACCEPT incoming to the port that Bittorrent
> uses. A tracker module to sniff traffic to known outbound tracker ports, to
> detect which port Bittorrent is using, and allow that inbound, seems a little
> bit excessive to me, not to mention that people set up trackers on the most
> varying range of seemingly random ports :-)
> 
> Either way, common sane principles of TCP/IP apply with Bittorrent too,
> if both parties are firewalled, you wont transfer any data between eachother.
> If one party (out of two) is unfirewalled, data can be transfered both ways
> between them, the firewalled party will established connection to the unfirewalled
> to get communication going.

The desired behaviour is that incoming BT connections would be accepted 
while an outgoing BT connection is in place. You can't open the port at 
any other time, there's no (legitimate) process listening and the 
firewall wouldn't know where to forward the socket in any case.

This belongs on another list.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
