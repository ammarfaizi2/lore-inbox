Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbTJOT4G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 15:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbTJOT4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 15:56:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57478 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264251AbTJOT4D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 15:56:03 -0400
Message-ID: <3F8DA644.50403@pobox.com>
Date: Wed, 15 Oct 2003 15:55:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@redhat.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci_get_slot()
References: <20031015183213.GG16535@parcelfarce.linux.theplanet.co.uk> <20031015184104.GA22373@kroah.com> <20031015185053.GH16535@parcelfarce.linux.theplanet.co.uk> <20031015193455.GA23727@kroah.com>
In-Reply-To: <20031015193455.GA23727@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Oct 15, 2003 at 07:50:53PM +0100, Matthew Wilcox wrote:
>>The only real way to do it is to inline pci_get_slot() into tg3.  Since I
>>also have a need for it in sym2, that doesn't seem like a sensible idea.
>>It would also be racy since it wouldn't take the pci_bus_lock.
> 
> 
> Ok, fair enough.  I'll add it to my tree to be sent to Linus after 2.6.0
> is out, if Jeff and David agree it's an ok tg3.c patch.


I'm OK with it...   I guess we'll be shipping tg3 and sym2 known-broken 
on PCI domain boxes?

Admittedly it's an uncommon case for tg3...

	Jeff



