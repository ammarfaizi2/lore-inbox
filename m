Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbTEZXsk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 19:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbTEZXsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 19:48:40 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:6112 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262361AbTEZXsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 19:48:39 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200305270001.h4R01mh24989@devserv.devel.redhat.com>
Subject: Re: [PATCH] IDE: fix "biostimings" and legacy chipsets' boot parameters
To: B.Zolnierkiewicz@elka.pw.edu.pl (Bartlomiej Zolnierkiewicz)
Date: Mon, 26 May 2003 20:01:48 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.30.0305262111440.7018-100000@mion.elka.pw.edu.pl> from "Bartlomiej Zolnierkiewicz" at Mai 26, 2003 09:16:36 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > IDE: fix "biostimings" and legacy chipsets' boot parameters interaction.
> >
> > I have to admit I don't care since biostimings is a stupid patch Linus
> > forced into the tree against my wishes. Its a great way to lose all your
> > data if you turn it on
> 
> You mean setting using_dma in ide_setup_dma() or comment in setup-pci.c?
> If it is data risky, why not kill it? I will be very happy - one sucky
> parameter less.

Very few BIOSes set up complete timings. The only ones that you can rely
on to handle this are those that do magic with bios tables such as
serverworks. In the serverworks case we implement the bios timing reading
per their NDA'd documents *regardless* of that setting.

Its only there because Linus applied the change despite my requests not to,
then refused to remove it. The sooner it dies the better

