Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314612AbSEPTfZ>; Thu, 16 May 2002 15:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314621AbSEPTfY>; Thu, 16 May 2002 15:35:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59917 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314612AbSEPTfY>;
	Thu, 16 May 2002 15:35:24 -0400
Message-ID: <3CE4098E.2070808@mandrakesoft.com>
Date: Thu, 16 May 2002 15:33:34 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/00200203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
CC: "Patrick Mochel (mochel@osdl.org)" <mochel@osdl.org>,
        "'davem@redhat.com'" <davem@redhat.com>,
        "'Greg@kroah.com'" <Greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: pci segments/domains
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7E45@orsmsx111.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grover, Andrew wrote:

>Well, ACPI calls them "segments" but a previous discussion (c.f. "RFC:
>Changes for PCI" from a year ago) called them domains.
>
>I don't care what they're called, but I wanted to bring them up and see what
>everyone thought about how best to implement them, or at least if anyone had
>an objection to adding a "segment" parameter to pci_scan_root.
>
>I certainly don't have a machine that uses these but some people do, and it
>sounds like it would be nice to handle them in an arch-neutral way.
>

alpha and sparc64 at least already do them.

I wouldn't mind making the PCI domain support a bit more explicit, 
though.  I think it's fair to be able to obtain a pointer to "struct 
pci_domain", which would most likely be defined in asm/pci.h for each arch.

    Jeff



