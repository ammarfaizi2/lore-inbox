Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276942AbRJDSis>; Thu, 4 Oct 2001 14:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277201AbRJDSii>; Thu, 4 Oct 2001 14:38:38 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:270 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276942AbRJDSi3>; Thu, 4 Oct 2001 14:38:29 -0400
Subject: Re: 100% sync block device on 2.2 ?
To: pit@root.at (Karl Pitrich)
Date: Thu, 4 Oct 2001 19:44:11 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0110041629170.1056-100000@warp.root.at> from "Karl Pitrich" at Oct 04, 2001 04:35:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pDTg-0003gD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i wrote a block driver for a custom battery-backup'ed sram-isa card
> which is io mapped. (kernel is 2.2.16, switch to 2.4.x impossible)
> i have a minix fs on it.
> everything works fine, except that i need my sram-disk _absolutely_
> in sync. i mounted -o sync, but the kernel does'nt seem to sync
> immediately.
> so after any reboot my data is corrupt, which is a problem.

You cannot achieve what you are trying to do without a journalling or
logging file system. JFFS and ext3 are available as 2.4 patches
