Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261897AbSJDVbs>; Fri, 4 Oct 2002 17:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261901AbSJDVbr>; Fri, 4 Oct 2002 17:31:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32780 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261897AbSJDVbq>;
	Fri, 4 Oct 2002 17:31:46 -0400
Message-ID: <3D9E09EF.6010207@pobox.com>
Date: Fri, 04 Oct 2002 17:36:47 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] pcibios_* removals for 2.5.40
References: <20021003224011.GA2289@kroah.com> <Pine.LNX.4.44.0210040930581.1723-100000@home.transmeta.com> <20021004165955.GC6978@kroah.com> <20021004205121.GA8346@kroah.com> <20021004205222.GB8346@kroah.com> <20021004205305.GC8346@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> diff -Nru a/drivers/net/aironet4500_card.c b/drivers/net/aironet4500_card.c
> --- a/drivers/net/aironet4500_card.c	Fri Oct  4 13:47:26 2002
> +++ b/drivers/net/aironet4500_card.c	Fri Oct  4 13:47:26 2002
> @@ -80,38 +77,29 @@
>  int awc4500_pci_probe(struct net_device *dev)
>  {
>  	int cards_found = 0;
> -	static int pci_index;	/* Static, for multiple probe calls. */
>  	u8 pci_irq_line = 0;
>  //	int p;
> -
> -	unsigned char awc_pci_dev, awc_pci_bus;
> -
> +	struct pci_dev *pdev = NULL;
> +		
>  	if (!pci_present()) 
>  		return -1;

pci_present can be eliminated



