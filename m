Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317624AbSIEPFT>; Thu, 5 Sep 2002 11:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317628AbSIEPFT>; Thu, 5 Sep 2002 11:05:19 -0400
Received: from thumper2.emsphone.com ([199.67.51.102]:55174 "EHLO
	thumper2.emsphone.com") by vger.kernel.org with ESMTP
	id <S317624AbSIEPFR>; Thu, 5 Sep 2002 11:05:17 -0400
Date: Thu, 5 Sep 2002 10:09:50 -0500
From: Andrew Ryan <genanr@emsphone.com>
To: linux-kernel@vger.kernel.org
Subject: ARP and alias IPs
Message-ID: <20020905150949.GA8112@thumper2.emsphone.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The linux implementation of ARP is causing me problems.  Linux sends out an
ARP request with the default interface as the sender address, rather than then
interface the request came on. 

For example

eth0   10.1.1.100
eth0:1 192.16.1.101 

and an ARP is received on 192.16.1.101, linux responds with
10.1.1.100 as the source address in the ARP request, rather than 192.16.1.101
(which FreeBSD, Solaris, and tru64 do).  To me, this is just plain wrong. 
The sender address should be an address on the subnet that the request came
from, not a different one.  Is there any way to fix this?

Andy
