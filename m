Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287720AbSAIQJG>; Wed, 9 Jan 2002 11:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287743AbSAIQIh>; Wed, 9 Jan 2002 11:08:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34830 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287720AbSAIQIT>; Wed, 9 Jan 2002 11:08:19 -0500
Subject: Re: [PATCH][RFCA] Sound: adding /proc/driver/{vendor}/{dev_pci}/ac97 entry
To: salvador@inti.gov.ar
Date: Wed, 9 Jan 2002 16:19:49 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org (Linux-kernel)
In-Reply-To: <3C3C6710.94FFF61A@inti.gov.ar> from "salvador" at Jan 09, 2002 12:51:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16OLS9-0001aF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +               if (proc_mkdir (proc_str, 0)) {
> +                       sprintf(proc_str, "driver/%s/%s", name,
> card->pci_dev->slot_name);
> +                       if (proc_mkdir (proc_str, 0)) {
> +                               sprintf(proc_str, "driver/%s/%s/ac97", name,
> card->pci_dev->slot_name);
> +                               create_proc_read_entry (proc_str, 0, 0,
> ac97_read_proc, codec);
> +                       }
> +               }

Where do you remove it. Also a card can have multiple ac97 codecs
