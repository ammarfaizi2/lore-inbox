Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318080AbSGMBL4>; Fri, 12 Jul 2002 21:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318082AbSGMBLz>; Fri, 12 Jul 2002 21:11:55 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:30716 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318080AbSGMBLz>; Fri, 12 Jul 2002 21:11:55 -0400
Subject: Re: Removal of pci_find_* in 2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020713003601.GA12118@kroah.com>
References: <20020713003601.GA12118@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Jul 2002 03:23:29 +0100
Message-Id: <1026527009.9958.69.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-07-13 at 01:36, Greg KH wrote:
> So if you own a PCI driver that does not conform to the "new" PCI api
> (using pci_register_driver() and friends) consider yourself warned.
> Your driver will NOT inherit any of the upcoming changes to the drivers
> tree, which might cause them to break.  Also remember, all of the people
> that are buying hotplug PCI systems for their datacenters will not buy
> your cards :)

I have several examples where the ordering of the PCI cards is critical
to get stuff like boot device and primary controller detection right.
pci_register_driver doesn't appear to have a good way to deal with this
or have I missed something ?


