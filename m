Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263890AbTLPWkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 17:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263945AbTLPWkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 17:40:43 -0500
Received: from fmr99.intel.com ([192.55.52.32]:38541 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S263890AbTLPWkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 17:40:41 -0500
Message-ID: <3FDF898D.2060902@intel.com>
Date: Wed, 17 Dec 2003 00:39:09 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: arjanv@redhat.com
CC: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org,
       Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Martin Mares <mj@ucw.cz>
Subject: Re: PCI Express support for 2.4 kernel
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com>	 <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es>	 <3FDDACA9.1050600@intel.com> <1071494155.5223.3.camel@laptop.fenrus.com>	 <3FDDBDFE.5020707@intel.com>	 <Pine.LNX.4.58.0312151154480.1631@home.osdl.org>	 <3FDEDC77.9010203@intel.com>  <3FDF3C6C.9030609@pobox.com> <1071596889.5223.7.camel@laptop.fenrus.com>
In-Reply-To: <1071596889.5223.7.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>>+	/* dummy read to flush PCI write */
>>>+	readb(addr);
>>>      
>>>
>>This is going to choke some hardware, I guarantee.
>>
>>You always want to make sure your flush is of the same size at the 
>>write.  Reading a byte from an address that the hardware defines as 
>>"32-bit writes only" can get ugly real quick ;-)
>>    
>>
>
>also reading back addr might not be the best choice in case some
>registers have side effects on reading, it's probably better to read
>back an address that is known to be ok to read (like the vendor ID
>field)
>
>  
>
Good idea!
