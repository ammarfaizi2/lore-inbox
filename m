Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265694AbUAKBdq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 20:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265699AbUAKBdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 20:33:46 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:32217 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S265694AbUAKBdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 20:33:44 -0500
Message-ID: <4000A9AA.30309@pacbell.net>
Date: Sat, 10 Jan 2004 17:40:58 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>
CC: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: USB hangs
References: <1073779636.17720.3.camel@dhcp23.swansea.linux.org.uk> <20040111002304.GE16484@one-eyed-alien.net> <200401110149.34654.oliver@neukum.org>
In-Reply-To: <200401110149.34654.oliver@neukum.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> Am Sonntag, 11. Januar 2004 01:23 schrieb Matthew Dharm:
> 
>>Where is USB kmalloc'ing with GFP_KERNEL?  I thought we tracked all those
>>down and eliminated them.
>>
> 
> 
> static int ohci_mem_init (struct ohci *ohci)
> {
> 	...
> }
> 
> This one here looks dangerous.

Since that happens as part of controller initialization,
long before usb-storage could possibly come into play ...
it doesn't seem to me like even a remote concern!



