Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265661AbTAXWsv>; Fri, 24 Jan 2003 17:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265786AbTAXWsv>; Fri, 24 Jan 2003 17:48:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27409 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265661AbTAXWst>;
	Fri, 24 Jan 2003 17:48:49 -0500
Message-ID: <3E31C498.9060403@pobox.com>
Date: Fri, 24 Jan 2003 17:56:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>
CC: "David S. Miller" <davem@redhat.com>, ink@jurassic.park.msu.ru,
       willy@debian.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] tg3.c: pci_{save,restore}_extended_state
References: <20030124152453.A4081@dsnt25.mro.cpqcorp.net> <20030124203402.GA4975@gtf.org> <20030124154635.A4161@dsnt25.mro.cpqcorp.net> <20030124.125121.78932406.davem@redhat.com> <20030124163341.A4366@dsnt25.mro.cpqcorp.net>
In-Reply-To: <20030124163341.A4366@dsnt25.mro.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wiedemeier, Jeff wrote:
> But right now, the driver does not have enough information to make it a
> driver specific decision. INT_LINE may not be enough to determine the
> vector to claim for LSIs and "Message Data" may not be enough to
> determine the vector to claim for MSIs. What is there is the irq field
> in struct pci_dev.
[...]

> If it needs to be made a driver decision, there needs to be some way to
> communicate the correct vector information for whichever option the
> driver is using (if there already is and I missed it, please let me
> know). Otherwise, it seems that trying to match spec behavior given the
> hardware design or disabling MSI at config time for these devices (such
> as through quirks) are the options.


Just to add... I think that the proposed pci_using_msi() could certainly 
store additional information in struct pci_dev, if it needed to... 
whether it is stored in arch-specific sysdata or in generic struct 
pci-dev, I leave as a question to the implementor ;-)

If "what is there is the irq field", then add the additional information 
you want :)

