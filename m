Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290869AbSARXMs>; Fri, 18 Jan 2002 18:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290870AbSARXMi>; Fri, 18 Jan 2002 18:12:38 -0500
Received: from topic-gw2.topic.com.au ([203.37.31.2]:62712 "EHLO
	mailhost.topic.com.au") by vger.kernel.org with ESMTP
	id <S290869AbSARXM1>; Fri, 18 Jan 2002 18:12:27 -0500
Date: Sat, 19 Jan 2002 10:12:03 +1100
From: Jason Thomas <jason@topic.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: network connections stalls
Message-ID: <20020118231203.GA22149@topic.com.au>
In-Reply-To: <20020118034055.GD5653@topic.com.au> <20020117.233817.24612693.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020117.233817.24612693.davem@redhat.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2002 at 11:38:17PM -0800, David S. Miller wrote:
> 
> Does the "InErrs" TCP counter in /proc/net/snmp increment on the
> receiver when this occurs?
> 
> It smells of bad checksumming...

Yep it increments by 7

--- snmp1.txt   Sat Jan 19 10:09:57 2002
+++ snmp2.txt   Sat Jan 19 10:10:25 2002
@@ -1,8 +1,8 @@
 Ip: Forwarding DefaultTTL InReceives InHdrErrors InAddrErrors ForwDatagrams InUnknownProtos InDiscards InDelivers OutRequests OutDiscards OutNoRoutes ReasmTimeout ReasmReqds ReasmOKs ReasmFails FragOKs FragFails FragCreates
-Ip: 2 64 192 0 0 0 0 0 148 248 0 0 0 0 0 0 0 0 0
+Ip: 2 64 322 0 0 0 0 0 256 359 0 0 0 0 0 0 0 0 0
 Icmp: InMsgs InErrors InDestUnreachs InTimeExcds InParmProbs InSrcQuenchs InRedirects InEchos InEchoReps InTimestamps InTimestampReps InAddrMasks InAddrMaskReps OutMsgs OutErrors OutDestUnreachs OutTimeExcds OutParmProbs OutSrcQuenchs OutRedirects OutEchos OutEchoReps OutTimestamps OutTimestampReps OutAddrMasks OutAddrMaskReps
-Icmp: 44 0 19 0 0 0 0 25 0 0 0 0 0 25 0 0 0 0 0 0 0 25 0 0 0 0 0
+Icmp: 66 0 41 0 0 0 0 25 0 0 0 0 0 25 0 0 0 0 0 0 0 25 0 0 0 0 0
 Tcp: RtoAlgorithm RtoMin RtoMax MaxConn ActiveOpens PassiveOpens AttemptFails EstabResets CurrEstab InSegs OutSegs RetransSegs InErrs OutRsts
-Tcp: 0 0 0 0 0 0 0 0 3 144 101 2 0 0
+Tcp: 0 0 0 0 0 0 0 0 3 250 166 2 7 0
 Udp: InDatagrams NoPorts InErrors OutDatagrams
-Udp: 3 0 0 122
+Udp: 3 0 0 168
