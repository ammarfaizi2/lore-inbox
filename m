Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272127AbRHVVOx>; Wed, 22 Aug 2001 17:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272123AbRHVVOm>; Wed, 22 Aug 2001 17:14:42 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25105 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272121AbRHVVOg>; Wed, 22 Aug 2001 17:14:36 -0400
Subject: Re: [PATCH,RFC] make ide-scsi more selective
To: mikpe@csd.uu.se (Mikael Pettersson)
Date: Wed, 22 Aug 2001 22:17:37 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        ionut@cs.columbia.edu
In-Reply-To: <no.id> from "Mikael Pettersson" at Aug 22, 2001 09:46:03 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZfNZ-0002J3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've been rather annoyed by a dual problem in the ide-scsi setup:
> during initialisation, ide-scsi will claim ALL currently unassigned
> IDE devices. This is a problem in modular setups, since there's
> no guarantee that currently unassigned devices actually are intended
> for ide-scsi.

The real problem is that the drivers are claiming resources on load not
on open. Why shouldnt I be able to load ide-cd and ide-scsi and open either
/dev/hda or /dev/sr0 but not both together ?

Alan
