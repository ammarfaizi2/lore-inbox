Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291359AbSBGV65>; Thu, 7 Feb 2002 16:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291346AbSBGV6s>; Thu, 7 Feb 2002 16:58:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23562 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291359AbSBGV6Z>; Thu, 7 Feb 2002 16:58:25 -0500
Subject: Re: [PATCH] Fix floppy io ports reservation
To: dwguest@win.tue.nl (Guest section DW)
Date: Thu, 7 Feb 2002 21:54:39 +0000 (GMT)
Cc: aia21@cus.cam.ac.uk (Anton Altaparmakov), linux-kernel@vger.kernel.org
In-Reply-To: <20020207202452.GA1527@win.tue.nl> from "Guest section DW" at Feb 07, 2002 09:24:52 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16YwV5-0001ax-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I asked a friend to check and on his Windows 2000 system the port
> > reservation was 0x3f2-0x3f5 + 0x3f7, i.e. it just excludes ports
> > 0x3f0-0x3f1, which are NOT used anywhere in the driver anyway.
> 
> ports 0x3f0 and 0x3f1 are used on certain PS/2 systems
> and on some very old AT clones

The driver must only reserve those ports on machines which needed them and
when it needs them (which it never actually does). The ports are used for
other superio related things on newer machines
