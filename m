Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290988AbSAaJMg>; Thu, 31 Jan 2002 04:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290987AbSAaJM0>; Thu, 31 Jan 2002 04:12:26 -0500
Received: from dark.pcgames.pl ([195.205.62.2]:41929 "EHLO dark.pcgames.pl")
	by vger.kernel.org with ESMTP id <S289037AbSAaJMP>;
	Thu, 31 Jan 2002 04:12:15 -0500
Date: Thu, 31 Jan 2002 10:12:05 +0100 (CET)
From: Krzysztof Oledzki <ole@ans.pl>
X-X-Sender: <ole@dark.pcgames.pl>
To: Tim Moore <timothymoore@bigfoot.com>
cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.21pre2; ide_set_handler; DMA timeout
In-Reply-To: <3C56FF07.304AFB48@bigfoot.com>
Message-ID: <Pine.LNX.4.33.0201310959510.21465-100000@dark.pcgames.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 Jan 2002, Tim Moore wrote:

> > driver. You may check some more recent version of IDE backport from
> > 2.4.x: http://www.ans.pl/ide/testing - the latest is ide.2.2.21.01282002-Ole,
> > but the new version of hpt driver has not been yet backported. I'm going
> > to do it tomorrow.
> I'll test the backport hpt driver when available.

OK, please try this:
http://www.ans.pl/ide/testing/ide.2.2.21.01312002-Ole.patch.gz

ide.2.2.21.01302002-Ole for linux kernel 2.2.21pre2: (test version)
o       new file: drivers/ide/idecomp.h with:
                create_proc_read_entry() for ide-proc.c
                pci_for_each_dev() for ide-pci.c and cs5530.c
                ARRAY_SIZE() for sis5513.c
                cpu_relax() for serverworks.c
o       backport from linux-2.4.17+ide.2.4.16.12102001.patch:
                alim15x3.c - 0.10
                hpt366.c - 0.22
                slc90e66.c
o       enable 80-pin cable detection for DELL and SUN in serverworks.c
o       use create_proc_info_entry() and proc_mkdir() in ide-proc.c.
o       enable "IDE Taskfile Access" and "IDE Taskfile IO" in Config.in

Is there any reason why you compiled kernel with IDE SCSI emulation?

BTW: Do you really have 36MHz PCI clock?

Best regards,

				Krzysztof Oledzki

