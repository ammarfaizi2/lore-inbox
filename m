Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbUKOQrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbUKOQrj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 11:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbUKOQrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 11:47:39 -0500
Received: from ip126.globalintech.pl ([62.89.81.126]:7960 "EHLO
	MAILSERVER.dmz.globalintech.pl") by vger.kernel.org with ESMTP
	id S261634AbUKOQri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 11:47:38 -0500
Message-ID: <4198DDA8.3000100@globalintech.pl>
Date: Mon, 15 Nov 2004 17:47:36 +0100
From: Blizbor <kernel@globalintech.pl>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6 native IPsec implementation question
References: <4198B2B6.9050803@globalintech.pl> <Pine.LNX.4.53.0411151455020.17543@yvahk01.tjqt.qr> <4198C1A4.8080707@globalintech.pl> <Pine.LNX.4.53.0411151557550.17812@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411151557550.17812@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2004 16:47:36.0708 (UTC) FILETIME=[CFB9CC40:01C4CB32]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

>You "sit" on the network card chip and then think of input and output.
>Btw, -j DROP will only drop what has not been matched up to now. So if you get
>to -j ACCEPT IPsec traffic beforehand (I think -m ah / -m esp, did not
>it?), they will never reach -j DROP.
>  
>
No, it's not like you think.

Situation is NOT EASY IF you have ONE VPN.
Just "close" eth0 for anything, allow AH,ESP,DNS from "any" IP addres,
then how you detect if tcp/389 is from VPN or form world ? You cant.
To make things harder - there are eth0, eth1, eth2 and eth3, two of them
has public IP addresses, two has private IP addresses, there is IPsec VPN
server running on both public addresses and a lot (32) of roadwarrior VPN
clients.

So, in this not easy situation firewalling is not possible.
Believe me.

But, how to implement firewall using iptables command is not my issue.
Lets assume that I just want to do "mrtg" traffic accounting....

So, my questions are still actual.

Regards,
Blizbor

