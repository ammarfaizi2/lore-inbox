Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbUCPOrD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUCPOqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:46:13 -0500
Received: from mail.convergence.de ([212.84.236.4]:64674 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261995AbUCPOX5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:23:57 -0500
Message-ID: <40570DF1.7090605@convergence.de>
Date: Tue, 16 Mar 2004 15:23:45 +0100
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][2.6] Additional i2c adapter flags for i2c client	isolation
References: <4056C805.8090004@convergence.de> <1079443611.1677.194.camel@newt>
In-Reply-To: <1079443611.1677.194.camel@newt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Adrian,

On 16.03.2004 14:26, Adrian Cox wrote:
> On Tue, 2004-03-16 at 09:25, Michael Hunold wrote:

>>What I'd like to have is that client can specify some sort of "class",
>>too, and that i2c adapters can tell the core that only clients where the
>>class is matching are allowed to probe their existence.
> 
> 
> How about a general "never probe" flag combined with a function to
> connect an adapter to a client? High level drivers like DVB or BTTV
> could then do something like:
> 	adapter = i2c_bit_add_bus(&my_card_ops);
> 	i2c_connect_client(adapter, &client_ops, address);
> 
> This problem comes up a lot, and i2c probing is only necessary for
> finding motherboard sensors. For add-in cards and embedded systems the
> driver developer normally knows exactly what is wired to what.

This is true for most devices (i2c eeprom, video decoder, ...), but not 
for all. All DVB cards have a device called "frontend" (basically a 
tuner with some additional stuff) connected via i2c.

Sometimes different frontends are used for the same revisons of one 
card, so we need the probe functionality at least for these kinds of 
devices.

> - Adrian Cox
> http://www.humboldt.co.uk/

CU
Michael.
