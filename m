Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284691AbRLUQRP>; Fri, 21 Dec 2001 11:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284688AbRLUQRF>; Fri, 21 Dec 2001 11:17:05 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48658 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284677AbRLUQQw>; Fri, 21 Dec 2001 11:16:52 -0500
Subject: Re: [2.4.17rc1] fatal problem: system time suddenly changes
To: andihartmann@freenet.de (Andreas Hartmann)
Date: Fri, 21 Dec 2001 16:26:41 +0000 (GMT)
Cc: pellegrini@mpcnet.com.br (Jeronimo Pellegrini),
        linux-kernel@vger.kernel.org (Kernel-Mailingliste),
        marcelo@conectiva.com.br (Marcelo Tosatti)
In-Reply-To: <3C234C84.6050802@athlon.maya.org> from "Andreas Hartmann" at Dec 21, 2001 03:51:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16HSVN-0000eF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > That's a VIA timer bug. The patch that fixes it was inthe kernel some
> > time ago, but was removed because the workaround was being triggered
> > when it shouldn't, if I remember correctly.

Its also not clear its the real truth. Fixing a latch handling case sorted
most stuff out, and there is a need for someone to fix the locking in some
other cases before assuming the workaround is correct - in fact it may
simply be masking the real locking error
