Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278769AbRKDFPj>; Sun, 4 Nov 2001 00:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278789AbRKDFPa>; Sun, 4 Nov 2001 00:15:30 -0500
Received: from mailout5-0.nyroc.rr.com ([24.92.226.122]:30394 "EHLO
	mailout5.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S278769AbRKDFPX>; Sun, 4 Nov 2001 00:15:23 -0500
Message-ID: <08dd01c164ef$db350190$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: "victor" <ixnay@infonegocio.com>
Cc: <linux-kernel@vger.kernel.org>, "Alan Cox" <alan@redhat.com>
In-Reply-To: <fa.it8dqhv.r6qaig@ifi.uio.no>
Subject: Re: linux 2.2.20 compile fails on alpha
Date: Sun, 4 Nov 2001 00:16:27 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> asm/pci.h: In function `pci_controller_num':
> asm/pci.h:62: structure has no member named `pci_host_index'
> asm/pci.h:63: warning: control reaches end of non-void function
> make: *** [init/main.o] Error 1

I was able to get 2.2.20 to compile by changing asm/pci.h line 62 to
"pci_hose_index" (s/host/hose/); see the struct definition at the top of
that file. Also I needed to add "#include <asm/errno.h>" to the same file to
get the definition of ENXIO... Be warned, I have not actually booted the
resulting kernel.

Are pci_hose_* really meant to be named like that, or was it an overzealous
search-and-replace?

Regards,
Dan

