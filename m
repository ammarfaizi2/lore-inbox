Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271307AbTHMB0L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 21:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271308AbTHMB0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 21:26:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23244 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271307AbTHMB0K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 21:26:10 -0400
Message-ID: <3F3993A4.40108@pobox.com>
Date: Tue, 12 Aug 2003 21:25:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, greg@kroah.com, willy@debian.org,
       davem@redhat.com, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
References: <20030812020226.GA4688@zip.com.au> <1060654733.684.267.camel@localhost> <20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk> <20030812053826.GA1488@kroah.com> <20030812112729.GF3169@parcelfarce.linux.theplanet.co.uk> <20030812180158.GA1416@kroah.com> <3F397FFB.9090601@pobox.com> <20030812171407.09f31455.rddunlap@osdl.org> <3F3986ED.1050206@pobox.com> <20030812173742.6e17f7d7.rddunlap@osdl.org> <20030813004941.GD2184@redhat.com>
In-Reply-To: <20030813004941.GD2184@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Tue, Aug 12, 2003 at 05:37:42PM -0700, Randy.Dunlap wrote:
>  > | I would much rather move the PCI ids out of the 
>  > | drivers altogether, into some metadata file(s) in the kernel source 
>  > | tree, than bloat up tg3, tulip, e100, and the other PCI id-heavy 
>  > | drivers' source code.
>  > 
>  > That last few lines certainly sounds desirable.
> 
> What exactly would be the benefit of this ?
> The only thing I could think of was out-of-kernel tools to do
> things like matching modules to pci IDs, but that seems to be
> done mechanically by various distros already reading the pci_driver
> structs.


Fundamentally, the PCI ID list is not C code.  And if anyone ever wants 
to get to the PCI ID lists at the _source code_ level, they have to 
parse C or assembler :)  It's data, so I say, put it in a data file. 
Stuffing the PCI ID list in C code is a sometimes convenient, sometimes 
inconvenient form of packaging, nothing more :)

I would rather store the PCI ID list in a more natural form, and then 
use small tool to generate the pci_device_id tables that are linked into 
the kernel.

	Jeff



