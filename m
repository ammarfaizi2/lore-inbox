Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279113AbRKFMEV>; Tue, 6 Nov 2001 07:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279144AbRKFMEB>; Tue, 6 Nov 2001 07:04:01 -0500
Received: from [213.97.184.209] ([213.97.184.209]:1152 "HELO piraos.com")
	by vger.kernel.org with SMTP id <S279113AbRKFMD7>;
	Tue, 6 Nov 2001 07:03:59 -0500
Date: Tue, 6 Nov 2001 13:03:43 +0100 (CET)
From: German Gomez Garcia <german@piraos.com>
To: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.13-ac7-8 IDE doesn't work as a module.
Message-ID: <Pine.LNX.4.33.0111061301250.3732-100000@hal9000.piraos.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	A typo while exporting symbols prevent to use IDE as a module
in 2.4.13-ac7+, to fix it, just move the two lines:

EXPORT_SYMBOL(export_ide_init_queue);
EXPORT_SYMBOL(export_probe_for_drive);

from ide.c to ide-probe.c (I put it at line 914 after the definitions of
both functions), and add ide-probe.o to the the export-objs line in the
Makefile.

	Regards,

	- german

-------------------------------------------------------------------------
German Gomez Garcia          | Send email with "SEND GPG KEY" as subject
<german@piraos.com>          | to receive my GnuPG public key.

