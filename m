Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286322AbSAPWwe>; Wed, 16 Jan 2002 17:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281787AbSAPWwX>; Wed, 16 Jan 2002 17:52:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11783 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S286238AbSAPWwK>;
	Wed, 16 Jan 2002 17:52:10 -0500
Message-ID: <3C46040B.B4992A1C@mandrakesoft.com>
Date: Wed, 16 Jan 2002 17:51:55 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Engebretsen <engebret@vnet.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcnet32
In-Reply-To: <200201162221.g0GMLpb21223@skunk.rchland.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Engebretsen wrote:
> -    while (i++ < 100)
> +    while (1)
>         if (lp->a.read_csr (ioaddr, 0) & 0x0100)
>             break;

If the hardware disappears or a PCI bus error occurs or various other
reasons, this change will loop forever...

-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
