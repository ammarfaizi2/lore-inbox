Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316243AbSEQOfY>; Fri, 17 May 2002 10:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316244AbSEQOfX>; Fri, 17 May 2002 10:35:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52489 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316243AbSEQOfW>;
	Fri, 17 May 2002 10:35:22 -0400
Message-ID: <3CE514B6.6070302@mandrakesoft.com>
Date: Fri, 17 May 2002 10:33:26 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/00200203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: ink@jurassic.park.msu.ru, andrew.grover@intel.com, mochel@osdl.org,
        Greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: pci segments/domains
In-Reply-To: <3CE4098E.2070808@mandrakesoft.com>	<20020517144755.A16767@jurassic.park.msu.ru>	<3CE512A7.70202@mandrakesoft.com> <20020517.071633.67125480.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>   From: Jeff Garzik <jgarzik@mandrakesoft.com>
>   Date: Fri, 17 May 2002 10:24:39 -0400
>
>   I know -- that's what I mean by being more explicit.  sysdata would 
>   become a pointer to struct pci_domain.
>   
>No thanks, I want to say what the layout is for
>this object.  What pci_domain will end up doing is
>making for one more dereference to "arch private"
>state and that stinks for performance :-)
>


See my previous message from the other day... this would be defined in 
each arch's asm/pci.h, which eliminates this problem you describe.  Each 
arch maintainer would indeed decide how to define it, though over time 
I'm sure it would grow commonly-named struct members.

My main want is cosmetic -- call a spade a spade, so to speak. 
 s/sysdata/pci_domain/  But doing so opens the door to increased 
flexibility.  Later steps can add common members needed by pci-to-pci 
IOMMU tricks which are common to most platforms.

    Jeff



