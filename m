Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316236AbSEQO0j>; Fri, 17 May 2002 10:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316237AbSEQO0i>; Fri, 17 May 2002 10:26:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36873 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316236AbSEQO0g>;
	Fri, 17 May 2002 10:26:36 -0400
Message-ID: <3CE512A7.70202@mandrakesoft.com>
Date: Fri, 17 May 2002 10:24:39 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/00200203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: "Grover, Andrew" <andrew.grover@intel.com>,
        "Patrick Mochel (mochel@osdl.org)" <mochel@osdl.org>,
        "'davem@redhat.com'" <davem@redhat.com>,
        "'Greg@kroah.com'" <Greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: pci segments/domains
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7E45@orsmsx111.jf.intel.com> <3CE4098E.2070808@mandrakesoft.com> <20020517144755.A16767@jurassic.park.msu.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:

>On Thu, May 16, 2002 at 03:33:34PM -0400, Jeff Garzik wrote:
>
>>I wouldn't mind making the PCI domain support a bit more explicit, 
>>though.  I think it's fair to be able to obtain a pointer to "struct 
>>pci_domain", which would most likely be defined in asm/pci.h for each arch.
>>
>
>We already have it - void *sysdata. Host-to-PCI (domain) controllers might
>be totally different even inside any given architecture, so trying to
>make this more generic would be pointless - you will end up with a pointer
>to arch/device specific data anyway.
>
I know -- that's what I mean by being more explicit.  sysdata would 
become a pointer to struct pci_domain.

>
>I can think of the only case where domain info might be interesting - if
>some device wants to know whether it can talk to another device directly.
>We have pci_controller_num(pdev) for this.
>

Like gets mentioned later in the thread, you don't want to start 
addressing based on number...

    Jeff




