Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288116AbSAHQDN>; Tue, 8 Jan 2002 11:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288122AbSAHQDD>; Tue, 8 Jan 2002 11:03:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54290 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288116AbSAHQC7>; Tue, 8 Jan 2002 11:02:59 -0500
Subject: Re: [problem captured] Re: cerberus on 2.4.17-rc2 UP
To: heckmann@hbe.ca (marc. h.)
Date: Tue, 8 Jan 2002 16:13:51 +0000 (GMT)
Cc: marcelo@conectiva.com.br (Marcelo Tosatti), linux-kernel@vger.kernel.org
In-Reply-To: <20020108164816.A5453@hbe.ca> from "marc. h." at Jan 08, 2002 04:48:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Nysp-0006tn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> end_request: buffer-list destroyed
> hda1: bad access: block=12440, count=-8
> end_request: I/O error, dev 03:01 (hda), sector 12440
> hda1: bad access: block=12448, count=-16

That looks like a race in the IDE/block layer (or somewhere above it maybe)
Someone trashed a request in progress.

> Is this a bug or could it be the hardware's fault? The hardware is new lspci

Other people have reported it too. Its clearly a kernel race
