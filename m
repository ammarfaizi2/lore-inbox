Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262222AbSJASmB>; Tue, 1 Oct 2002 14:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262223AbSJASmB>; Tue, 1 Oct 2002 14:42:01 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:26788 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262222AbSJASmA>; Tue, 1 Oct 2002 14:42:00 -0400
Message-ID: <3D99ED03.8040600@us.ibm.com>
Date: Tue, 01 Oct 2002 11:44:19 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: Greg KH <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Martin Bligh <mjbligh@us.ibm.com>
Subject: Re: [rfc][patch] driverfs multi-node(board) patch [2/2]
References: <Pine.LNX.4.44.0210011125290.27710-100000@cherise.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> Matt,
> 
> I have some comments about the structure of the code, but those will come 
> in another email..
Cool...  Any/all comments are definitely welcome...

>>[root@elm3b79 devices]# tree -d root/sys/
>>root/sys/
>>|-- node0
>>|   `-- sys
>>|       |-- cpu0
>>|       |-- cpu1
>>|       |-- cpu2
>>|       |-- cpu3
>>|       `-- memblk0
>>|-- node1
>>|   `-- sys
>>|       |-- cpu4
>>|       |-- cpu5
>>|       |-- cpu6
>>|       |-- cpu7
>>|       `-- memblk1
>>|-- pic0
>>`-- rtc0
> 
> 
> Shouldn't nodes (or, erm, boards) be added as children of the root? 
Um, yes!  I don't quite know how, though...  I call sys_register_root() 
for each of the nodes...  That call seems to parent them under the 
root/sys directory...  How can I change that?

> Aren't all types of devices present on the various boards (PCI, etc)?
Yes...  I have some patches that I'm working that will put PCI busses 
and devices into the topology infrastructure (both in-kernel & via 
driverfs).  Again, this is just a first pass of what I'd like to see... ;)

Cheers!

-Matt


> 
> 	-pat
> 
> 


