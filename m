Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292837AbSCKUQS>; Mon, 11 Mar 2002 15:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292841AbSCKUQI>; Mon, 11 Mar 2002 15:16:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13326 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292837AbSCKUP5>; Mon, 11 Mar 2002 15:15:57 -0500
Subject: Re: ide timer trbl ...
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Mon, 11 Mar 2002 20:31:27 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        davidel@xmailserver.org (Davide Libenzi),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        axboe@suse.de (Jens Axboe)
In-Reply-To: <3C8D0FA2.6040803@evision-ventures.com> from "Martin Dalecki" at Mar 11, 2002 09:12:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kWS8-0001f5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ahh... this is really helpfull. Indeed I see the same. At most
> places ide_set_handler get's just called without clearing
> it before. This means that the IRQ handler routine abused as timeout handler

In all the command cases thats because the previous command state has
completed. I'm pretty sure there is one path alone wrong and its in the 
WIP DMA timeout stuff
