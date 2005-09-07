Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbVIGB4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbVIGB4J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 21:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVIGB4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 21:56:09 -0400
Received: from mail.dvmed.net ([216.237.124.58]:43754 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751191AbVIGB4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 21:56:08 -0400
Message-ID: <431E48B1.7050600@pobox.com>
Date: Tue, 06 Sep 2005 21:56:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: Miroslaw Mieszczak <mieszcz@zabrze.zigzag.pl>,
       linux-kernel@vger.kernel.org, Netdev List <netdev@vger.kernel.org>
Subject: Re: Patch for link detection for R8169
References: <431DA887.2010008@zabrze.zigzag.pl> <20050906194602.GA20862@electric-eye.fr.zoreil.com>
In-Reply-To: <20050906194602.GA20862@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> Miroslaw Mieszczak <mieszcz@zabrze.zigzag.pl> :
> 
>>There is a patch to driver of RLT8169 network card. This match make 
>>possible detection of the link status even if network interface is down.
>>This is usefull for laptop users.
> 
> 
> (side note: there is maintainer entry for the r8169 and network related
> patches are welcome on netdev@vger.kernel.org)
> 
> Can you elaborate why it is usefull for laptop users ?
> 
> I am sceptical: tg3/bn2x/skge do not seem to allow it either.
> 
> Jeff, is it a requirement ?

Generally most drivers power down hardware, MAC at least, when the 
interface is down.  As such, many drivers do not (cannot), as written, 
report any useful link information.

IF the phy is not powered down, when the interface goes down, and IF 
hardware permits, it would certainly be nice to report link state when 
interface is down.  This is a hardware-dependent, driver-dependent choice.

	Jeff


