Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbVIAVVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbVIAVVN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbVIAVVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:21:13 -0400
Received: from web53605.mail.yahoo.com ([206.190.37.38]:15015 "HELO
	web53605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750790AbVIAVVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:21:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=FF4gTI24WVq6qITty/YMm7rGbULCiQ2I4TDD1zbBRAHx2g+nE3PhrmdSz2abyrp9azvAPKutCrxqleNnlctFHZ+7uVxjSsCcpKE+OFdyeAmsSflmMqG4UMbTcdtotu34C3A7mOCvblAZo7Y3NMozkutu9n+9KdhX/aUpA5SfRR8=  ;
Message-ID: <20050901212110.19192.qmail@web53605.mail.yahoo.com>
Date: Fri, 2 Sep 2005 07:21:10 +1000 (EST)
From: Steve Kieu <haiquy@yahoo.com>
Subject: Re: Very strange Marvell/Yukon Gigabit NIC networking problems
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050901110913.5d9fba44@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this the correct summary of the problem
> scenarios.
> Assume each one starts from cold boot (power off).
> 
> * 2.6.13(skge) boot                    => Good
> * 2.6.13(sk98lin) boot                 => Good
> * 2.6.13 + SK version of sk98lin       => Good
> * XP boot                              => Good 
XP boot: No good if before 2.6.13 runs on the hardware
and do the normal shuttdown or reboot or power off.

The same for all linux kernel before 2.6.13 (tested
2.6.12, 2.6.11)

> 
> Okay, now the cases where one OS is run first and
> a reboot is done to a second, or in the case of
> just Linux, this should be the same as rmmoding on
> driver and modprobing
> 
> 	Second
> First   | skge | sk98lin | XP
> skge  	| OK   |  BAD    | BAD
> sk98lin | ok   |  OK     | ok 
> XP      | ok   |  ok     | OK
> 

a litle bit confusing, just one line to describe it:

If run 2.6.13 and up the NIC, it is working. Shuttdown
or reboot using /sbin/halt (means power completely off
and on) or /sbin/reboot all other OSs failed to enable
the NIC except 2.6.13.

to restore the normal working of the NIC, boot 2.6.13
and do a hot power reset. (press the reset button)

cheers


S.KIEU


	

	
		
____________________________________________________ 
Do you Yahoo!? 
The New Yahoo! Movies: Check out the Latest Trailers, Premiere Photos and full Actor Database. 
http://au.movies.yahoo.com
