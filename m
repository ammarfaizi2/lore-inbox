Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278624AbRJXPzd>; Wed, 24 Oct 2001 11:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278604AbRJXPz1>; Wed, 24 Oct 2001 11:55:27 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26375 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278624AbRJXPyk>; Wed, 24 Oct 2001 11:54:40 -0400
Subject: Re: fdisk: "File size limit exceeded on fdisk" 2.4.10 to 2.4.13-pre6
To: timtas@dplanet.ch (Tim Tassonis)
Date: Wed, 24 Oct 2001 17:01:37 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <E15wQDj-0000HT-00@lttit> from "Tim Tassonis" at Oct 24, 2001 05:45:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wQTJ-0001v1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm using a Red Hat 6.2 system with glibc 2.1.3 (glibc-2.1.3-22), the
> latest for Red Hat 6.2. Switching to 7.x would mean to upgrade the whole
> system, I guess I can't just take the glibc rpm out of 7.x and everything
> still runs fine?
> 
> So that means I'm really fucked?

glibc 2.1.x has minimal support for 64bit file size handling. You probably
need to build 64bit aware tools. You might also be hitting a device bug that
seems to be in Linus kernel where devices are inheriting the file size limit
of the underlying fs the /dev node is on. However I thought that was long
fixed.

