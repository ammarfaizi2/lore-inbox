Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285073AbSA1Vxq>; Mon, 28 Jan 2002 16:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286758AbSA1Vxg>; Mon, 28 Jan 2002 16:53:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37643 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285073AbSA1VxX>; Mon, 28 Jan 2002 16:53:23 -0500
Subject: Re: [PATCH?] Crash in 2.4.17/ptrace
To: manfred@colorfullife.com (Manfred Spraul)
Date: Mon, 28 Jan 2002 22:05:31 +0000 (GMT)
Cc: dan@debian.org (Daniel Jacobowitz), linux-kernel@vger.kernel.org,
        akpm@zip.com.au (Andrew Morton)
In-Reply-To: <001401c1a844$ae7c51b0$010411ac@local> from "Manfred Spraul" at Jan 28, 2002 10:33:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VJu7-0001w0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For framebuffers addresses, there is no page structure, and then the
> page reference count updates read/write to random memory.

If it is a physical pci bus object why do we need to refcount it, surely
"no page" is ok. Its just up to the driver not to do anything stupid and
the core code to honour the pci/pci transfer quirks (or when faced with
a hard one just say "no")
