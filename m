Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbTDHWpA (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 18:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbTDHWpA (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 18:45:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49835 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262198AbTDHWo6 (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 18:44:58 -0400
Message-ID: <3E93538C.9010306@pobox.com>
Date: Tue, 08 Apr 2003 18:56:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@brodo.de>
Subject: Re: [PATCHES 2.5.67] PCMCIA hotplugging, in-kernel-matching and depmod
 support
References: <20030408223111.GA25785@bougret.hpl.hp.com>
In-Reply-To: <20030408223111.GA25785@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> Jeff Garzik wrote :
>>That was a big stumbling block when I last looked at the "big picture"
>>for pcmcia -- in-kernel drivers still required probe assistance from
>>userspace via the /etc/pcmcia/* bindings.
> 
> 
> 	No ! Please don't do that, it will only bring madness.

Nope.  It's already a solved problem :)  More below...


> 	Example :
> 	Lucent/Agere Orinoco wireless card :
> 		manfid 0x0156,0x0002
> 		possible drivers : wlan_cs ; orinoco_cs
> 	Intersil PrismII and clones (Linksys, ...) :
> 		manfid 0x0156,0x0002
> 		possible drivers : prism2_cs ; hostap_cs
> 
> 	Please explain me in details how your stuff will cope with the
> above, and how to make sure the right driver is loaded in every case
> and how user can control this.
> 	If your scheme can't cope with the simple real life example
> above (I've got those cards on my desk, and those drivers on my disk),
> then it's no good to me.

These cases already exist for PCI, so pcmcia behavior should follow what 
the kernel does when the PCI core sees such.

	Jeff



