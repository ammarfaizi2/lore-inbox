Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272817AbRISTTO>; Wed, 19 Sep 2001 15:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274139AbRISTTF>; Wed, 19 Sep 2001 15:19:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7699 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272817AbRISTSx>; Wed, 19 Sep 2001 15:18:53 -0400
Subject: Re: Why is Device3Dfx driver (voodoo1/2) not in the kernel?
To: steven.griffiths@iname.com (Steven Griffiths)
Date: Wed, 19 Sep 2001 20:24:06 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BA89327.2030503@iname.com> from "Steven Griffiths" at Sep 19, 2001 01:44:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jmx4-0003bf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does anyone know why the Device3Dfx kernel driver is not in the standard 
> kernel?

Because it lets anyone crash the machine by feeding a Voodoo1 garbage. To
get something like that into the kernel I suspect would involve

-	Making sure glide is using the fifo
-	Writing a parser for packet1-packet5 commands to verify they 
	are valid

then voodoo would be safe for user direct access.

Alan
