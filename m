Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262185AbSJASUk>; Tue, 1 Oct 2002 14:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262186AbSJASUk>; Tue, 1 Oct 2002 14:20:40 -0400
Received: from air-2.osdl.org ([65.172.181.6]:16273 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S262185AbSJASUj>;
	Tue, 1 Oct 2002 14:20:39 -0400
Date: Tue, 1 Oct 2002 11:28:07 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Matthew Dobson <colpatch@us.ibm.com>
cc: Greg KH <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Martin Bligh <mjbligh@us.ibm.com>
Subject: Re: [rfc][patch] driverfs multi-node(board) patch [2/2]
In-Reply-To: <3D99E722.8020704@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0210011125290.27710-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Matt,

I have some comments about the structure of the code, but those will come 
in another email..

> [root@elm3b79 devices]# tree -d root/sys/
> root/sys/
> |-- node0
> |   `-- sys
> |       |-- cpu0
> |       |-- cpu1
> |       |-- cpu2
> |       |-- cpu3
> |       `-- memblk0
> |-- node1
> |   `-- sys
> |       |-- cpu4
> |       |-- cpu5
> |       |-- cpu6
> |       |-- cpu7
> |       `-- memblk1
> |-- pic0
> `-- rtc0

Shouldn't nodes (or, erm, boards) be added as children of the root? 
Aren't all types of devices present on the various boards (PCI, etc)?

	-pat

