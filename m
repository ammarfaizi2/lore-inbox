Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291005AbSAaJsA>; Thu, 31 Jan 2002 04:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291008AbSAaJru>; Thu, 31 Jan 2002 04:47:50 -0500
Received: from c007-h000.c007.snv.cp.net ([209.228.33.206]:49593 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S291005AbSAaJrf>;
	Thu, 31 Jan 2002 04:47:35 -0500
X-Sent: 31 Jan 2002 09:47:33 GMT
Message-ID: <3C5912AF.9147B567@bigfoot.com>
Date: Thu, 31 Jan 2002 01:47:27 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.21pre2-Ole i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.21pre2; ide_set_handler; DMA timeout
In-Reply-To: <Pine.LNX.4.33.0201310959510.21465-100000@dark.pcgames.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Oledzki wrote:
> 
> On Tue, 29 Jan 2002, Tim Moore wrote:
> 
> > > driver. You may check some more recent version of IDE backport from
> > > 2.4.x: http://www.ans.pl/ide/testing - the latest is ide.2.2.21.01282002-Ole,
> > > but the new version of hpt driver has not been yet backported. I'm going
> > > to do it tomorrow.
> > I'll test the backport hpt driver when available.
> 
> OK, please try this:
> http://www.ans.pl/ide/testing/ide.2.2.21.01312002-Ole.patch.gz

OK, got it.  I need to sleep first :)

> ide.2.2.21.01302002-Ole for linux kernel 2.2.21pre2: (test version)
> o       new file: drivers/ide/idecomp.h with:
>                 create_proc_read_entry() for ide-proc.c
>                 pci_for_each_dev() for ide-pci.c and cs5530.c
>                 ARRAY_SIZE() for sis5513.c
>                 cpu_relax() for serverworks.c
> o       backport from linux-2.4.17+ide.2.4.16.12102001.patch:
>                 alim15x3.c - 0.10
>                 hpt366.c - 0.22
>                 slc90e66.c
> o       enable 80-pin cable detection for DELL and SUN in serverworks.c
> o       use create_proc_info_entry() and proc_mkdir() in ide-proc.c.
> o       enable "IDE Taskfile Access" and "IDE Taskfile IO" in Config.in
> 
> Is there any reason why you compiled kernel with IDE SCSI emulation?

For CD-R.  Pulled it out for extra disk space.

> BTW: Do you really have 36MHz PCI clock?

Yes.  Memory bus is 72.  I will also test at 33/66.

> Best regards,
> 
>                                 Krzysztof Oledzki

Rgds,
tim.

--
