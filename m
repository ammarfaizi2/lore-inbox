Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129404AbQKTBhN>; Sun, 19 Nov 2000 20:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129532AbQKTBhD>; Sun, 19 Nov 2000 20:37:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22308 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129404AbQKTBgo>; Sun, 19 Nov 2000 20:36:44 -0500
Subject: Re: 2.4.0-test11-pre7: isapnp hang
To: hpa@zytor.com (H. Peter Anvin)
Date: Mon, 20 Nov 2000 01:06:47 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8v9rf6$54k$1@cesium.transmeta.com> from "H. Peter Anvin" at Nov 19, 2000 04:32:38 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13xfQ1-0003CR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Try reserving ports 0x300-0x31f on the kernel command line
> ("reserve=0x300,0x20").
> 
> I'm surprised isapnp uses a port in such a commonly used range,
> though.

It seems to be a combination of two bugs. The one I posted a patch for and
something odd that is taking port 0x279 before the pnp probe is run, which
suggests a link order issue. Although in truth _nobody_ should be claing
that anyway

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
