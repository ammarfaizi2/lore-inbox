Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270513AbTGST6X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 15:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270571AbTGST6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 15:58:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39613 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270502AbTGST6S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 15:58:18 -0400
Message-ID: <3F19A651.2080503@pobox.com>
Date: Sat, 19 Jul 2003 16:13:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: azarah@gentoo.org
CC: Catalin BOIE <util@deuroconsult.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: libata driver update posted
References: <3F1711C8.6040207@pobox.com>	 <Pine.LNX.4.53.0307180924020.19703@hosting.rdsbv.ro>	 <3F17F28C.9050105@pobox.com>	 <1058542771.13515.1599.camel@workshop.saharacpt.lan>	 <20030718154322.GB27152@gtf.org> <1058645294.23174.7.camel@nosferatu.lan>
In-Reply-To: <1058645294.23174.7.camel@nosferatu.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schlemmer wrote:
> On Fri, 2003-07-18 at 17:43, Jeff Garzik wrote:
> 
> Slower this side.  The Maxtor 40GB (ata133) is however just set to
> udma33, where the Seagate 20GB (ata100) driver is set correctly to
> udma100.

Yeah, that's expected:  Parallel ATA (PATA) requires cable detection to 
go beyond UDMA/33, and my driver doesn't do that yet [since I'm 
concentrating on SATA].


> The Seagate start off ok (about 35mb/s), but then after doing some heavy
> disk io, it also just drops to the 20mb/s region.

That's definitely interesting.  Is "heavy disk I/O" the hdparm stuff you 
described, or something else too?

	Jeff



