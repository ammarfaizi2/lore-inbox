Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262111AbSJNTRj>; Mon, 14 Oct 2002 15:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262118AbSJNTRj>; Mon, 14 Oct 2002 15:17:39 -0400
Received: from zeus.kernel.org ([204.152.189.113]:32142 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262111AbSJNTRi>;
	Mon, 14 Oct 2002 15:17:38 -0400
Message-ID: <3DAB198C.4030709@pobox.com>
Date: Mon, 14 Oct 2002 15:22:52 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jaroslav Kysela <perex@perex.cz>
CC: Adam Belay <ambx1@neo.rr.com>,
       "torvalds@transmeta.com" <torvalds@transmeta.com>,
       "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
       "greg@kroah.com" <greg@kroah.com>,
       "jdthood@yahoo.co.uk" <jdthood@yahoo.co.uk>,
       "boissiere@nl.linux.org" <boissiere@nl.linux.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PnP Layer Rewrite V0.7 - 2.4.42
References: <Pine.LNX.4.33.0210142101000.7202-100000@pnote.perex-int.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaroslav Kysela wrote:
> On Mon, 14 Oct 2002, Adam Belay wrote:
> 
> 
>>Linux Plug and Play Rewrite V0.7
>>
>>After much testing the Linux PnP Rewrite is ready to be included. For
>>those who would like to try it, be sure to enable debugging or else it
>>will operate silently. Also enable both PnP protocols.
> 
> 
> A few notes. Please, could you leave the raw proc interface for ISA PnP?

If a rewrite is being done, there are a lot better ways to do this than 
via ->proc_read and ->proc_write...  plus overall procfs usage should be 
deprecated where reasonable/possible...


> I mean isapnp_proc_bus_read() function. Also, encoding device/vendor to 
> 7-byte string seems like wasting bytes and CPU cycles. If you use 2/2 byte 
> format, you'll spare 3 bytes and comparing of two short values (or one 
> int value) is always less expensive.

ASCII has always been preferred.  google for "Linus", "linux-kernel", 
and "ASCII" to see Linus's several postings on the subject...


> Anyway, I like this code. It seems that you don't use standard pci_dev / 
> pci_bus structures as I was forced by Linus at ISA PnP code inclusion 
> time. But it's true that we have new device model, so these things might 
> be private. Also, don't forget to remove additional ISA PnP members from 
> pci structures when Linus approves pnp_dev and pnp_card structures.

agreed.

Regards,

	Jeff



