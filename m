Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315437AbSHMOQZ>; Tue, 13 Aug 2002 10:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315439AbSHMOQZ>; Tue, 13 Aug 2002 10:16:25 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:2222 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315437AbSHMOQY>;
	Tue, 13 Aug 2002 10:16:24 -0400
Date: Tue, 13 Aug 2002 07:17:41 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, colpatch@us.ibm.com
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, Greg KH <gregkh@us.ibm.com>
Subject: Re: [patch] PCI Cleanup
Message-ID: <1847016869.1029223059@[10.10.2.3]>
In-Reply-To: <1029239133.20980.10.camel@irongate.swansea.linux.org.uk>
References: <1029239133.20980.10.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2002-08-13 at 01:08, Matthew Dobson wrote:
> 
>> -	if (!value) 
>> -		return -EINVAL;
>> -
>> -	result = pci_conf1_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
>> -		PCI_FUNC(dev->devfn), where, 2, &data);
>> -
> 
> This stil has the same problems as it did last time you posted it. The
> pointless NULL check and the increased complexity over duplicating about
> 60 lines of code and having pci_conf1 ops cleanly as we do in 2.4.
> 
> The !value check is extremely bad because it turns a critical debuggable
> software error into a silent unnoticed mistake.
> 
> Fixing the code instead of just resending it might improve the changes
> of it being merged no end.

Alan, please *look* at the patch. The NULL check is already
there, he's REMOVING about 60 lines of duplicated code,
reducing the complexity, and shifting the indirection up one
level to get rid of redundancy.

If you want to delete the NULL check as well, that's fine, but
totally a side issue. Ironically, the very snippet of code you
quoted is all prefaced with "-", no?

M.

