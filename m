Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290796AbSBXTnu>; Sun, 24 Feb 2002 14:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290797AbSBXTnl>; Sun, 24 Feb 2002 14:43:41 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20231 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290796AbSBXTnb>; Sun, 24 Feb 2002 14:43:31 -0500
Subject: Re: fix: lp.c wrong return code
To: WHarms@bfs.de
Date: Sun, 24 Feb 2002 19:58:07 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <vines.sxdD+0FGSwA@SZKOM.BFS.DE> from "WHarms@bfs.de" at Feb 24, 2002 06:34:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16f4md-0002VJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> calling the ioctl( LPSETIRQ ) the driver returns EINVAL (Invalid argument)instead of ENOSYS.
> Fix : return ENOSYS (Function not implemented)

ENOSYS is for a syscall not supported.

> if EINVAL is correct, you can delete the entiere entry, EINVAL in default.

It should actually be ENOTTY ...
