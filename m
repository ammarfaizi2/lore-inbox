Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312600AbSEQLjp>; Fri, 17 May 2002 07:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314451AbSEQLjo>; Fri, 17 May 2002 07:39:44 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:5386 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S312600AbSEQLjn>; Fri, 17 May 2002 07:39:43 -0400
Date: Fri, 17 May 2002 15:39:03 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "David S. Miller" <davem@redhat.com>
Cc: jgarzik@mandrakesoft.com, andrew.grover@intel.com, mochel@osdl.org,
        Greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: pci segments/domains
Message-ID: <20020517153903.A24121@jurassic.park.msu.ru>
In-Reply-To: <20020517144755.A16767@jurassic.park.msu.ru> <20020517.034048.34092752.davem@redhat.com> <20020517151154.B16767@jurassic.park.msu.ru> <20020517.040421.38226563.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 04:04:21AM -0700, David S. Miller wrote:
> I'm not saying pci_domain structure will help, I am only
> saying that domain number is not the way to figure out
> the ability to do DMA between two devices :-)

Agreed. What about
dma_addr_t pci_to_pci_map_single(struct pci_dev *master,
				 struct pci_dev *target,
				 dma_addr_t tgt_addr, size_t size, int dir)

Could be implemented without much pain if there is enough interest. :-)

> I know for a fact that you can do PCI-to-PCI DMA between
> two PCI domains on Alpha.

Ah, indeed. I should check the docs before posting... :-\

Ivan.
