Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277511AbRJOMTm>; Mon, 15 Oct 2001 08:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277514AbRJOMTc>; Mon, 15 Oct 2001 08:19:32 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9234 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277511AbRJOMT2>; Mon, 15 Oct 2001 08:19:28 -0400
Subject: Re: [PATCH] PnP BIOS -- bugfix; update devlist on setpnp
To: pazke@orbita1.ru (Andrey Panin)
Date: Mon, 15 Oct 2001 13:25:15 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, jdthood@mail.com (Thomas Hood)
In-Reply-To: <20011015160100.A31571@orbita1.ru> from "Andrey Panin" at Oct 15, 2001 04:01:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15t6nz-000205-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 		    ^^^^^^^^^^^^^^^^^^^^^
> Looks wrong for me, we are trying to reserve _memory_ range with request_re=
> gion().

We should be creating memory and I/O regions as unused but exist rather than
requesting them as owned. We do want to reserve memory regions as present
but unused to void assigning PCI devices over them
