Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265237AbUHMKOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbUHMKOP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 06:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUHMKOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 06:14:14 -0400
Received: from fep18.inet.fi ([194.251.242.243]:57547 "EHLO fep18.inet.fi")
	by vger.kernel.org with ESMTP id S265237AbUHMKON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 06:14:13 -0400
From: Jan Knutar <jk-lkml@sci.fi>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: BitTorrent and iptables (was: Can not read UDF CD)
Date: Fri, 13 Aug 2004 13:14:01 +0300
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <B1ECE240295BB146BAF3A94E00F2DBFF090213@piramida.hermes.si> <cfgjk6$gbi$1@gatekeeper.tmr.com>
In-Reply-To: <cfgjk6$gbi$1@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408131314.02352.jk-lkml@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 August 2004 23:33, Bill Davidsen wrote:

> I used torrent to pull something the other day, and while I could pull, 
> no one could connect to get data from me. I have my iptables set to 
> ESTABLISHED,RELATED so iptables may not know about torrent.

You probably need to explicitly ACCEPT incoming to the port that Bittorrent
uses. A tracker module to sniff traffic to known outbound tracker ports, to
detect which port Bittorrent is using, and allow that inbound, seems a little
bit excessive to me, not to mention that people set up trackers on the most
varying range of seemingly random ports :-)

Either way, common sane principles of TCP/IP apply with Bittorrent too,
if both parties are firewalled, you wont transfer any data between eachother.
If one party (out of two) is unfirewalled, data can be transfered both ways
between them, the firewalled party will established connection to the unfirewalled
to get communication going.
