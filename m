Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292982AbSBVUHN>; Fri, 22 Feb 2002 15:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292976AbSBVUHD>; Fri, 22 Feb 2002 15:07:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64264 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292966AbSBVUGu>;
	Fri, 22 Feb 2002 15:06:50 -0500
Message-ID: <3C76A4D8.A7838605@mandrakesoft.com>
Date: Fri, 22 Feb 2002 15:06:48 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linuxdiskcert.org>
CC: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>,
        Vojtech Pavlik <vojtech@suse.cz>, Arjan van de Ven <arjanv@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <Pine.LNX.4.10.10202221143290.2519-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> Also not that ATA/IDE drivers were not using 2.4 PCI API and likewise was
> stable for a while.

Stable?  Yes.  But it's not modular nor compatible with current efforts
like 2.4 cardbus or 2.4 hotplug pci or 2.5 device mode.  If one cannot
do
	modprobe piix4_ide
and have the right things happen automatically, the system is not
modular.  If it doesn't use the PCI API, it's implementing CardBus
support in a non-standard way if at all.


> > This is need for transparented support for cardbus and hotplug PCI, not
> 
> This is HOST level operation not DEVICE, and you do not see the differenc.

I do.  I am talking about a HOST api here.


> It is a shame that I will now have to start from scratch to create another
> API for hotplug device for ATA/ATAPI that was migrating into SCSI because
> of the ide-scsi driver.

Why not work with Patrick to make sure his device model properly
supports disks?

	Jeff


-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |
