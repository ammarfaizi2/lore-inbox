Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287937AbSABThW>; Wed, 2 Jan 2002 14:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287932AbSABTgf>; Wed, 2 Jan 2002 14:36:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46857 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287931AbSABTgS>;
	Wed, 2 Jan 2002 14:36:18 -0500
Message-ID: <3C33612D.7BAC53EC@mandrakesoft.com>
Date: Wed, 02 Jan 2002 14:36:13 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Albert Cranford <ac9410@bellsouth.net>
CC: ollie@sis.com.tw, linux-kernel@vger.kernel.org,
        Keith Owens <kaos@ocs.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH]take2 2.4.18-pre1 sound/trident fix with newer binutils
In-Reply-To: <3C3313E4.10B5E0D2@bellsouth.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cranford wrote:
> -static void __exit trident_cleanup_module (void)
> +static void __devexit trident_cleanup_module (void)
>  {
>         pci_unregister_driver(&trident_pci_driver);
>  }

cleanup_module (module_exit) never ever has a reason to be __devexit. 
It is run once at module exit, regardless of CONFIG_HOTPLUG.  If !MODULE
the function is dropped, that's the only requirement.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
