Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318017AbSHQPWR>; Sat, 17 Aug 2002 11:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318018AbSHQPWR>; Sat, 17 Aug 2002 11:22:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50444 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318017AbSHQPWR>;
	Sat, 17 Aug 2002 11:22:17 -0400
Message-ID: <3D5E6B10.9070106@mandrakesoft.com>
Date: Sat, 17 Aug 2002 11:26:08 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. J. Lu" <hjl@lucon.org>
CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, dhinds <dhinds@sonic.net>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: New fix for CardBus bridge behind a PCI bridge
References: <20020809172140.A30911@sonic.net> <20020810222355.A13749@lucon.org> <20020812104902.A18430@lucon.org> <20020812110431.A14125@sonic.net> <20020812112911.A18947@lucon.org> <20020812122158.A27172@sonic.net> <20020812140730.A21710@lucon.org> <20020812154851.A20073@sonic.net> <20020812202942.A27362@lucon.org> <20020816194825.A7086@jurassic.park.msu.ru> <20020816224950.A17930@lucon.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. J. Lu wrote:> On Fri, Aug 16, 2002 at 07:48:25PM +0400, Ivan 
Kokshaysky wrote:
> 
>>On Mon, Aug 12, 2002 at 08:29:42PM -0700, H. J. Lu wrote:
>>
>>>I was told all PCI_CLASS_BRIDGE_PCI bridges were transparent. The non-
>>>transparent ones have class code PCI_CLASS_BRIDGE_OTHER. This new patch
>>>only checks PCI_CLASS_BRIDGE_PCI and works for me.
>>
>>I guess that info came from Intel ;-)  Interesting, but completely wrong.
>>The devices they call "non-transparent PCI-to-PCI bridges" aren't classic
>>PCI-to-PCI bridges at all, that's why they are PCI_CLASS_BRIDGE_OTHER.
>>It's more to do with CPU-to-CPU bridges.
>>In our terms, "transparent" PCI-to-PCI bridge means subtractive decoding one.
>>Your previous patch makes much more sense, although a) it should belong to
>>generic pci code b) is way incomplete.
>>
>>Please try this one instead.
>>
> 
> 
> CardBus works now. But I can no longer load usb-uhci. My X server no
> longer works. Your patch is not right.


I would be willing to bet there is some silliness in the X server, at 
least.  It's PCI code has always left a lot to be desired...

	Jeff




