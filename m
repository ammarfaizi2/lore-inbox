Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSGMNf2>; Sat, 13 Jul 2002 09:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313202AbSGMNf1>; Sat, 13 Jul 2002 09:35:27 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:29166 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313190AbSGMNf0>; Sat, 13 Jul 2002 09:35:26 -0400
Subject: Re: Removal of pci_find_* in 2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020712.181214.15590856.davem@redhat.com>
References: <20020713003601.GA12118@kroah.com>
	<1026527009.9958.69.camel@irongate.swansea.linux.org.uk> 
	<20020712.181214.15590856.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Jul 2002 15:46:55 +0100
Message-Id: <1026571615.9956.100.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-13 at 02:12, David S. Miller wrote:
>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: 13 Jul 2002 03:23:29 +0100
>    
>    I have several examples where the ordering of the PCI cards is critical
>    to get stuff like boot device and primary controller detection right.
>    pci_register_driver doesn't appear to have a good way to deal with this
>    or have I missed something ?
> 
> Cards get registered in the order they appear on the bus, or at least
> that is the way the algorithm worked the last time I looked.

For most cards that is all that has to be turned from a "happens to
work" into a "officially this is what happens". I've replied about how
to handle other stuff in an earlier message. Its not a big thing, and
getting rid of most of pci_find_device will help. We still have people
needing to find other devices so there are refcount/locking things to
handle akin to what was done to make the old networking dev_get() type
stuff actually DTRT

