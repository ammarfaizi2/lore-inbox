Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWFFHhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWFFHhN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 03:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWFFHhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 03:37:13 -0400
Received: from mail.dgt.com.pl ([195.117.141.2]:43013 "EHLO dgt.com.pl")
	by vger.kernel.org with ESMTP id S1750822AbWFFHhL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 03:37:11 -0400
Message-ID: <448530FC.4020107@dgt.com.pl>
Date: Tue, 06 Jun 2006 09:38:36 +0200
From: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.8.0.2) Gecko/20060405 SeaMonkey/1.0.1
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Dual via-rhine on EPIA PD6000E
References: <44843EFB.4030704@dgt.com.pl> <Pine.LNX.4.61.0606051629240.20741@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0606051629240.20741@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There is a difference between ioports and iomem.
>
>   
Of course I know, but look at this:

# cat /proc/ioports
d000-d0ff : 0000:00:0f.0
  d000-d0ff : via-rhine
e400-e4ff : 0000:00:12.0
  e400-e4ff : via-rhine

# cat /proc/iomem  
de000000-de0000ff : 0000:00:0f.0
  de000000-de0000ff : via-rhine
de002000-de0020ff : 0000:00:12.0
  de002000-de0020ff : via-rhine

from ifoconfig:
eth0: Interrupt:10 Base address: *0xe000*
eth1: Interrupt:11 Base address: *0x4000* <<is it I/O or mem ???


> "Not working" is vague. No packet transmission even though the link is 
> active?
>
>   
#mii-tool
eth0: negotiated 100baseTx-FD flow-control, link ok
eth1: negotiated 100baseTx-FD flow-control, link ok

Huh! Now it started. But it's first time from four days. Before it i had 
no frames received.



