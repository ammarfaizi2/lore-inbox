Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLOXh5>; Fri, 15 Dec 2000 18:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129597AbQLOXhr>; Fri, 15 Dec 2000 18:37:47 -0500
Received: from sco.sco.COM ([132.147.128.9]:51464 "HELO sco.sco.COM")
	by vger.kernel.org with SMTP id <S129319AbQLOXhb>;
	Fri, 15 Dec 2000 18:37:31 -0500
Message-ID: <3A3AA38E.A6A13759@cruzio.com>
Date: Fri, 15 Dec 2000 15:04:46 -0800
From: Bruce Korb <bkorb@cruzio.com>
Reply-To: bkorb@cruzio.com
Organization: Home
X-Mailer: Mozilla 4.7 [en] (X11; U; SCO_SV 3.2 i386)
X-Accept-Language: en
MIME-Version: 1.0
To: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, tytso@valinux.com
Subject: Re: [patch] 2.2.18 PCI_DEVICE_ID_OXSEMI_16PCI954
In-Reply-To: <Pine.LNX.4.30.0012152140350.3740-100000@lt.wsisiz.edu.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Trabinski wrote:
> include/linux/pci_ids.h:#define PCI_DEVICE_ID_OXSEMI_16PCI954   0x9501
> 
> (IMHO that is correct), but in kernel 2.2.18 we have:
> (include/kernel/pci.h)
> #define PCI_DEVICE_ID_OXSEMI_16PCI954PP        0x9513
>                                      ^^
> 
> Please correct, if I'm wrong, but IMHO it shuld be:
> (include/kernel/pci.h)
> #define PCI_DEVICE_ID_OXSEMI_16PCI954  0x9513

Please correct me if *I* am wrong, but shouldn't the names be
different if the values are different?

Also, excuse me while I soap-box for a moment:  This and other
inconsistencies
would be easier to deal with if there were a single repository for PCI
information from which all the PCI device tables and ID enumerations
were derived.  I have posted the technology that can easily be adapted
to emit both 2.2 and 2.4 flavors of tables, though only PCI-IDE stuff
for 2.4 is currently implemented.

  See  ftp://autogen.linuxave.net/pub/PCIDEV.tgz

Tiny drawback:  you must download and use this to generate
all the output tables:

  ftp://autogen.linuxave.net/pub/autogen-5.1.3.tar.gz

Homepage (with broken download link due to SourceForge outage):

  http://AutoGen.SourceForge.net/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
