Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287325AbRL3CsB>; Sat, 29 Dec 2001 21:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287322AbRL3Crm>; Sat, 29 Dec 2001 21:47:42 -0500
Received: from hera.cwi.nl ([192.16.191.8]:43986 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S287318AbRL3Crb>;
	Sat, 29 Dec 2001 21:47:31 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 30 Dec 2001 02:47:30 GMT
Message-Id: <UTC200112300247.CAA141891.aeb@cwi.nl>
To: jlladono@pie.xtec.es
Subject: Re: 2.4.x kernels, big ide disks and old bios
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> # cat /proc/ide/hdc/settings
> name                    value           min             max             mode
> ----                    -----           ---             ---             ----
> bios_cyl                119150          0               65535           rw
> bios_head               16              0               255             rw
> bios_sect               63              0               63              rw

> What's the meaning of the 65535 max limit in bios_cyl?

It is meaningless.

(Maybe there was some meaning long ago, for example because
HDIO_GETGEO only uses a 16-bit field for #cyls.
These days bios_cyl is not used anywhere. Not in the kernel,
not in user space. It is just some random number, computed
by taking disk-size / (heads*secs).)
