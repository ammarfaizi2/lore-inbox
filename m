Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbSKMQOt>; Wed, 13 Nov 2002 11:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261973AbSKMQOt>; Wed, 13 Nov 2002 11:14:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12560 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261963AbSKMQOt>;
	Wed, 13 Nov 2002 11:14:49 -0500
Message-ID: <3DD27C0C.70506@pobox.com>
Date: Wed, 13 Nov 2002 11:21:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: "David S. Miller" <davem@redhat.com>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       linux-kernel@vger.kernel.org,
       Alexander Vlasenko <intrnl_edu@ilyichevsk.odessa.ua>
Subject: Re: dmesg of 2.5.45 boot on NFS client
References: <200211061605.gA6G5xp14090@Port.imtp.ilyichevsk.odessa.ua> <200211131457.gADEvKp15095@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200211061605.gA6G5xp14090@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

> mii-tool -F 100baseTx-FD eth0
>
> does not work in 2.5 while working fine in 2.4.
> What should I do? Fix eth driver?
> Use never mii-tool or equivalent?
>
> # mii-tool --version
> mii-tool.c 1.9 2000/04/28 00:56:08 (David Hinds)
>
> # lspci
> 01:08.0 Ethernet controller: Intel Corp. 82820 (ICH2) Chipset Ethernet 
> Controller (rev 03)


Addressing only this specific issue, and not the larger $thread issue...

Depends on what driver and version you are using.  It is preferred these 
days to force the media using ethtool.  But that said, if a NIC driver 
allows you to force in 2.4 and not in 2.5, that definitely sounds like 
an eth driver bug.

	Jeff



