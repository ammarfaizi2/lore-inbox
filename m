Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264598AbUBJIVu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 03:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265718AbUBJIVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 03:21:50 -0500
Received: from compaq.com ([161.114.1.205]:64772 "EHLO
	ztxmail01.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S264598AbUBJIVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 03:21:49 -0500
Date: Tue, 10 Feb 2004 13:55:19 +0530 (IST)
From: Raj <obelix123@toughguy.net>
X-X-Sender: obelix123@localhost.localdomain
To: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] packet_sendmsg_spkt incorrectly truncates an interface
 name
In-Reply-To: <20040210.165220.85391060.maeda@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.56.0402101352080.1484@localhost.localdomain>
References: <20040210.163023.112606425.maeda@jp.fujitsu.com>
 <20040209234341.0075159b.akpm@osdl.org> <20040210.165220.85391060.maeda@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Feb 2004, MAEDA Naoaki wrote:

> Hi,
> 
> > > Obviously, max name length of a network interface name is IFNAMESIZ-1, 
> > > which is 15.
> > 
> > Yes, but sockaddr_pkt.spkt_device[] is only 14 bytes for some reason.
> 
> Oops! I have not checked it.
> Does anybody know the reason why it is only 14 bytes?
>
include/linux/socket.h
struct sockaddr {
...
char sa_data[14]; /* 14 bytes of protocol address */
};

A 14 byte field here too !. Maybe there is an explanation. 

/Raj
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
