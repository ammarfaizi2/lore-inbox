Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270867AbUJUTRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270867AbUJUTRF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 15:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270866AbUJUTRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 15:17:03 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:23695 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S270864AbUJUTN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 15:13:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=AS2uBCxj8k73pezPzjp7zg2gys+6QKTiSTYkqRqsF/JRmqywmcsXN5XIEtgGGNdLDqTPJxNcNkDUcSbfqTTzwEGfP4JVn03jqcQM1mN8zNU8yd9ftm1k2TzPI4RVZ7/D9cW2o8p0CcBxtMQiQvwe7/zB8iq7P16Ffp2DVO+VaAc=
Message-ID: <58cb370e041021121317083a3a@mail.gmail.com>
Date: Thu, 21 Oct 2004 21:13:57 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Mark Lord <lkml@rtr.ca>
Subject: Re: [PATCH 2.4.28-pre4-bk6] delkin_cb: new driver for Cardbus IDE CF adaptor
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <41780393.3000606@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41780393.3000606@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

please also cc: linux-ide@vger.kernel.org

> An equivalent patch for 2.6.xx is being worked on.

generally it should be like that: 2.6.x first, 2.4.x later

> + *  This is slightly peculiar, in that it is a PCI driver,
> + *  but is NOT an IDE PCI driver -- the IDE layer does not directly
> + *  support hot insertion/removal of PCI interfaces, so this driver
> + *  is unable to use the IDE PCI interfaces.  Instead, it uses the
> + *  same interfaces as the ide-cs (PCMCIA) driver uses.
> + *  On the plus side, the driver is also smaller/simpler this way.

IDE layer doesn't support hot insertion/removal of _any_ interfaces

ide_unregister() calls are not allowed unless somebody fixes locking
(Alan fixed many issues but some more work is still needed)

Bartlomiej
