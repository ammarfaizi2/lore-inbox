Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbUL0A52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbUL0A52 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 19:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbUL0A52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 19:57:28 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:42091 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261535AbUL0A5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 19:57:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=n5/dVKnf3/qmDAxOySwbSULa9f1sfXLosCZF4mT55uJ2cTAYBbgWk+FCpr9Rw9x8HjVXoXSzRaHjPY1bSesG6OFPGbV23IIbxY2aVEXumT9uDgFNPTPMBS1n9AqQUhyENLZjuuJjsj85Aof8abNEf9WIZEw10gjfqtUJiF/xDNA=
Message-ID: <58cb370e04122616577e1bd33@mail.gmail.com>
Date: Mon, 27 Dec 2004 01:57:10 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.6.10-ac1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1104103881.16545.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1104103881.16545.2.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.6.10-ac1
> o       Revert AX.25 protocol breakage                  (Alan Cox)
> o       Remove bogus obsolete option junk from 2.6.10   (Alan Cox)
>         ide changes
>         | Options are often useful, so should be kept.
>         | Especially stuff like serialize

IMHO this is counter productive.

Most of these options are pure braindamage (they were obsoleted to
verify what is what) and they paper over real bugs in core or host drivers.

What do you need 'serialize' option for?

> o       Fix bogus dma_ naming in the 2.6.10 patch       (Alan Cox)

It is on purpose, we really don't need 'ide_' prefix in ide_hwif_t.
The rest of ide_dma_* functions will lose ide_* prefix over time.

Bartlomiej
