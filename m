Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129851AbQKVNft>; Wed, 22 Nov 2000 08:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131736AbQKVNfj>; Wed, 22 Nov 2000 08:35:39 -0500
Received: from ns.caldera.de ([212.34.180.1]:12305 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129682AbQKVNff>;
	Wed, 22 Nov 2000 08:35:35 -0500
Date: Wed, 22 Nov 2000 14:04:57 +0100
Message-Id: <200011221304.OAA26697@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: adam@yggdrasil.com ("Adam J. Richter")
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch(?): pci_device_id tables for drivers/scsi in 2.4.0-test11
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20001122045154.A13572@baldur.yggdrasil.com>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001122045154.A13572@baldur.yggdrasil.com> you wrote:

> --opJtzjQTFsWo+cga
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline


> 	Here is my first pass at adding pci_device_id tables to all
> PCI scsi drivers in linux-2.4.0-test11.  It implements a compromise
> regarding named initializers for pci_device_id table entries: shorter
> tables or tables that contain anonymous constants use the named fields,
> but the few longer tables where the purpose of the constants are more
> clearly labelled do not use named fields, because those tables would
> be really big otherwise (in terms of lines of source code, not what
> they compile into).

IMHO the pci tables look much cleaner without named initiliters.
They are really ugly if we nest structures and arrays.
The other argument for named initilizers don't aren't true in this
case too.  Neither there are lots of NULL-initilized fields nor is
there any reason to add new fields (the pci tables are external
API, because of MODULE_DEVICE_TABLE).

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
