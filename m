Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbTLPR4I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 12:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbTLPR4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 12:56:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41381 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261965AbTLPR4F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 12:56:05 -0500
Message-ID: <3FDF4727.8010503@pobox.com>
Date: Tue, 16 Dec 2003 12:55:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
       Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Martin Mares <mj@ucw.cz>
Subject: Re: PCI Express support for 2.4 kernel
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com>	 <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es>	 <3FDDACA9.1050600@intel.com> <1071494155.5223.3.camel@laptop.fenrus.com>	 <3FDDBDFE.5020707@intel.com>	 <Pine.LNX.4.58.0312151154480.1631@home.osdl.org>	 <3FDEDC77.9010203@intel.com>  <3FDF3C6C.9030609@pobox.com> <1071596889.5223.7.camel@laptop.fenrus.com>
In-Reply-To: <1071596889.5223.7.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2003-12-16 at 18:10, Jeff Garzik wrote:
>>This is going to choke some hardware, I guarantee.
>>You always want to make sure your flush is of the same size at the 
>>write.  Reading a byte from an address that the hardware defines as 
>>"32-bit writes only" can get ugly real quick ;-)
> 
> 
> also reading back addr might not be the best choice in case some
> registers have side effects on reading, it's probably better to read
> back an address that is known to be ok to read (like the vendor ID
> field)


Hum.  Never seen this in a PCI config register, but it's certainly 
possible...  good point.

	Jeff



