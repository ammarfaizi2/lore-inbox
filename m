Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTDHWuN (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 18:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbTDHWuN (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 18:50:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:428 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262228AbTDHWuM (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 18:50:12 -0400
Message-ID: <3E9354D3.8090805@pobox.com>
Date: Tue, 08 Apr 2003 19:01:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Dominik Brodowski <linux@brodo.de>
CC: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: [PATCHES 2.5.67] PCMCIA hotplugging, in-kernel-matching and depmod
 support
References: <20030408205623.GA5253@brodo.de> <20030408212059.GA5358@gtf.org> <20030408213403.GA5250@brodo.de>
In-Reply-To: <20030408213403.GA5250@brodo.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski wrote:
> On Tue, Apr 08, 2003 at 05:20:59PM -0400, Jeff Garzik wrote:
>>Will we see pcmcia id lists making their way into low-level drivers?

> In the drivers I converted (~20 or so...) this is done already. You can 
> find them at http://www.brodo.de/pcmcia/ , for example the network drivers
> (all of them should be converted) at
> http://www.brodo.de/pcmcia/pcmcia-2.5.67-drivers_network .
> 
> For example, a part of pcnet_cs.c looks like this now:
> 
> static struct pcmcia_device_id pcnet_ids[] = {
> 	{ PCMCIA_DEVICE_VERS1("2412LAN", 0x67f236ab) },
> 	{ PCMCIA_DEVICE_VERS12("ACCTON", "EN2212", 0xdfc6b5b2, 0xcb112a11) },
> 	...
> 	{ PCMCIA_MFC_DEVICE_MANF_CARD(0, 0x0105, 0xea15) },
> 	{ },
> };
> MODULE_DEVICE_TABLE(pcmcia, pcnet_ids);

Very cool...


> As strings can't be passed to userspace in file2alias.c, I've chosen the
> crc32 value of the string as the matching identifier for the userspace
> hotplug script.

This sounds like a problem to be solved, not worked around...  the 
source should have the strings presented directly, and I'm sure a 
creative and smart person such as yourself can conceive of at least 
one... ;-)

	Jeff




