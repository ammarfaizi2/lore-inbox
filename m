Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270524AbTHQTUy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 15:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270642AbTHQTUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 15:20:54 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:42638 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270524AbTHQTUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 15:20:51 -0400
Subject: Re: [PATCH] 9/8 Backport recent 2.6 IDE updates to 2.4.x
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: andersen@codepoet.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andries Brouwer <aebr@win.tue.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030817191701.GA23859@codepoet.org>
References: <20030817191701.GA23859@codepoet.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061148010.23520.0.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 17 Aug 2003 20:20:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-17 at 20:17, Erik Andersen wrote:
> IDE layer was reverted to a "late 2.4.19-pre-acX version" and has
> been gone ever since...  Any particular reason the baby was
> tossed out with the proverbial bathwater?

In theory the device mapper can do the work ide-raid is doing and do it 
better. That was the plan anyway

> Anyway, this patch fixes up the 2.4.x ide raid drivers so they
> compile up with the latest and greatest.  I will leave it to 
> others to decide if the pdcraid and silraid superblocks might
> be located somewhere past the capacity of an unsigned long...

The 2.4 block layer has a 32bit block limit so if it does they'll have
to use 2.6 anyway. Looks fine

