Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287208AbSACMdv>; Thu, 3 Jan 2002 07:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287206AbSACMdm>; Thu, 3 Jan 2002 07:33:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7429 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287200AbSACMdY>; Thu, 3 Jan 2002 07:33:24 -0500
Subject: Re: kernel 2.4.17 crashes on SCSI-errors
To: R.Oehler@GDImbH.com
Date: Thu, 3 Jan 2002 12:43:37 +0000 (GMT)
Cc: linux-scsi@vger.kernel.org (Scsi), linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.20020103130541.R.Oehler@GDImbH.com> from "R.Oehler@GDImbH.com" at Jan 03, 2002 01:05:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16M7De-0008Dx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Isn't anybody recognizing, that this bug is serious?

My 2.4.9-ac kernel tree here seems to be behaving

> 1) I compiled the SCSI-stuff as modules.
> 2) I put an erased MO-Medium in a MO-SCSI-drive.
[erased and formatted I assume ?]
> 3) I connected the drive to the computer.
> 4) I typed "modprobe sd_mod"
> 5) Crash! Serial console said:
> 
> tick login: invalid operand: 0000

BUG trap. Turn on verbose bug reporting, also run the  oops you then
get through ksymoops so that its actually readable by others. List what
scsi controller you use too.

The RH tree I'm running backed out a couple of scsi error handling changes
because we saw strange deadlocks. I don't think those are in Marcelo's tree
because I never had time to work out why they had to be reverted

Alan
