Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264269AbTEZF1l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 01:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbTEZF1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 01:27:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45841 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264269AbTEZF1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 01:27:40 -0400
Date: Sun, 25 May 2003 22:40:25 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] add ata scsi driver
In-Reply-To: <3ED1A664.1020307@pobox.com>
Message-ID: <Pine.LNX.4.44.0305252236400.10183-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 May 2003, Jeff Garzik wrote:
> 
> Direction:  SATA is much more suited to SCSI, because otherwise you wind 
> up re-creating all the queueing and error handling mess that SCSI 
> already does for you. 

Last I looked, the SCSI interfaces were much nastier than the native 
queueing, and if there is anything missing I'd rather put it at that 
layer, instead of making everything use the SCSI layer.

Because when you talk about error handling messes, you're talking SCSI. 
THAT is messy. At least judging by the fact that a lot of SCSI drivers 
don't seem to get it right.

In other words: I'd really like to see what you can do with a _native_
request queue driver, and what the probloems are. And maybe port _those_ 
parts of SCSI to it.

> And for specifically Intel SATA, drivers/ide flat out doesn't work (even 
> though it claims to).

Well, I don't think it claimed to, until today. Still doesn't work?

		Linus

