Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261749AbTCGTj0>; Fri, 7 Mar 2003 14:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261750AbTCGTj0>; Fri, 7 Mar 2003 14:39:26 -0500
Received: from ip-161-71-171-238.corp-eur.3com.com ([161.71.171.238]:18358
	"EHLO columba.www.eur.3com.com") by vger.kernel.org with ESMTP
	id <S261749AbTCGTjZ>; Fri, 7 Mar 2003 14:39:25 -0500
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: andewid@tnonline.net
cc: linux-kernel@vger.kernel.org
Message-ID: <80256CE2.006CEFC2.00@notesmta.eur.3com.com>
Date: Fri, 7 Mar 2003 19:49:50 +0000
Subject: Re: Entire LAN goes boo with 2.5.64
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Some things you might want to look at:
   Is the Linux box sending any traffic (look at the stats in ifconfig)?
   Does a packet sniffer like http://www.ethereal.com/ give any clues as to the
type of traffic on the network?
   Does the same thing occur if you run less processes, e.g. boot into run level
1 or 3?
   Are there any processes consuming an unreasonable amount of CPU time on the
Linux box?
   Is there a process which is being restarted many times a second, so top or ps
shows a radiply increasing PID?

It could be some network-aware process which has got stuck in a tight loop
sending requests to your windows box, e.g. a DHCP client.
I mention the DHCP client specifically because they sometimes get upset if you
don't enable some specific kernel networking options like CONFIG_PACKET or
CONFIG_FILTER & WinRoute might be acting as the DHCP server.

     Jon


