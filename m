Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287969AbSAHIGr>; Tue, 8 Jan 2002 03:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287966AbSAHIGh>; Tue, 8 Jan 2002 03:06:37 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:16953 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S287968AbSAHIGV>;
	Tue, 8 Jan 2002 03:06:21 -0500
Message-ID: <3C3AA7FE.2060304@dplanet.ch>
Date: Tue, 08 Jan 2002 09:04:14 +0100
From: Giacomo Catenazzi <cate@dplanet.ch>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: esr@thyrsus.com, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
In-Reply-To: <Pine.LNX.4.33.0201070955480.867-100000@segfault.osdlab.org> <Pine.LNX.4.33.0201071908580.16327-100000@Appserv.suse.de> <20020107185001.GK7378@kroah.com> <20020107185813.GL7378@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jan 2002 08:06:20.0530 (UTC) FILETIME=[5B3C4520:01C1981B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg KH wrote:

> On Mon, Jan 07, 2002 at 10:50:01AM -0800, Greg KH wrote:
> 
>>And the /sbin/hotplug program knows about _all_ devices that the
>>currently compiled kernel can handle due to the MODULE_DEVICE_TABLE tags
>>in the drivers.
>>
> 
> Along these lines, I am very disappointed in looking at the
> autoconfigure stuff in CML2.  It should be taking all of the device and
> driver matching information from the kernel itself, as it is already
> specified there.
> 
> Look at the modules.*map files.  They specify the kernel drivers that
> specific devices work for.  They are automatically created from the
> kernel that you just built.


modules.*map exist only on compiled kernel. And entry depends on
architecture and on configuration.

But don't worry. I use the kernel source to find the
MODULES_DEVICE_TABLE (with a partially automated script) to build the
new tables.
For USB and PNP this works great. For PCI I have some more problems:
the item found with MODULES_DEVICE_TABLE are the item marked with '#!'.
You see that the not all drivers use MODULES_DEVICE_TABLE.
An the most important missing dirvers are the IDE cards.

> 
> Eric, if you are going to keep your "2000+" configuration probes up to
> date by hand, good luck.  Look at all of the new USB drivers that have
> been added in just the 2.5.2-pre series alone.  That's a lot of data to
> keep track of.
> 
> The rest of us have decided to rely on automatic tools for this process :)


Slowly I make the proces more automatic (adding more 'special' cases),
i.e. I now I try to find the '#IFDEF' in the middle of the
*_device_id tables and setting the data correctly).

The sources is always the kernel.

	giacomo

