Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272859AbRIXMVe>; Mon, 24 Sep 2001 08:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273413AbRIXMVM>; Mon, 24 Sep 2001 08:21:12 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:264 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272859AbRIXMVB>; Mon, 24 Sep 2001 08:21:01 -0400
Subject: Re: /proc/partitions hosed
To: toon@vdpas.hobby.nl
Date: Mon, 24 Sep 2001 13:26:13 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010924124131.A4755@vdpas.hobby.nl> from "toon@vdpas.hobby.nl" at Sep 24, 2001 12:41:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15lUoP-0002Js-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It didn't get trough the boot-sequence (RedHat-7.1).
> After some investigation it turned out that it hang in
> the kudzu script, and further on also in the netfs script.
> The programs `/usr/sbin/updfstab', `/usr/sbin/kudzu' and
> the command `mount -a' are all falling into a loop.

The scsi partition handling code in 2.4.10 is broken

The cause seems to be the new gendisk changes, although quite why is still
a mystery.

ALan
