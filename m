Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271053AbUJVA1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271053AbUJVA1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 20:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271159AbUJVA0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 20:26:31 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:20695 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S271158AbUJVAPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 20:15:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=fL4FJZbTsMpVGahCjaAxSBfySvOkxNqs4rJQiuaJTKJcMYxRR8QWDRah4rxb2z5CBaDA5atzl085eGKA+NrGg5Qzac43hNndWK54ZjyJcElpTpVbYLjagPZPEBd8pR2GNGqjeJd4ISLZvMVtC/tiDoOqEnIMMWe7noOrgt3i6S0=
Message-ID: <58cb370e04102117153a92725d@mail.gmail.com>
Date: Fri, 22 Oct 2004 02:15:03 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Mark Lord <lkml@rtr.ca>
Subject: Re: [PATCH 2.4.28-pre4-bk6] delkin_cb: new driver for Cardbus IDE CF adaptor
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <41784F51.5000308@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41780393.3000606@rtr.ca>
	 <58cb370e041021121317083a3a@mail.gmail.com>
	 <1098394354.17096.174.camel@localhost.localdomain>
	 <41783CDF.80007@rtr.ca> <58cb370e04102115572e992d75@mail.gmail.com>
	 <41784F51.5000308@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wrt to 2.6.x version

> +       memset(&hw, 0, sizeof(hw));
> +       ide_init_hwif_ports(&hw, (ide_ioreg_t)(base + 0x10),
> +                                (ide_ioreg_t)(base + 0x1e), NULL);

please use ide_std_init_ports()

> +       rc = ide_register_hw(&hw, &hwif);
> +       if (rc < 0)     /* ide_register_hw likes to be invoked twice (buggy) */
> +               rc = ide_register_hw(&hw, &hwif);

is this needed in 2.6.x and if so why?

> +               drive->id->csfo = 0; /* workaround for idedisk_open bug */

ditto
