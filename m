Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314358AbSESLxb>; Sun, 19 May 2002 07:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314375AbSESLxa>; Sun, 19 May 2002 07:53:30 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34316 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314358AbSESLx3>; Sun, 19 May 2002 07:53:29 -0400
Subject: Re: AUDIT of 2.5.15 copy_to/from_user
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Sun, 19 May 2002 13:13:41 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net
In-Reply-To: <E179IA6-0002eQ-00@wagner.rustcorp.com.au> from "Rusty Russell" at May 19, 2002 02:18:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E179PZF-0003gC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> drivers/char/nwflash.c:158:		ret = copy_to_user(buf, (void *)(FLASH_BASE + p), count);

Real bug - Fixed in next 2.4 -ac tree
> drivers/scsi/scsi_ioctl.c:383:        return copy_to_user(arg, dev->host->pci_dev->slot_name,

Real bug - fixed in next 2.4 -ac tree

> drivers/sgi/char/sgiserial.c:1239:	return copy_to_user(retinfo,&tmp,sizeof(*retinfo));

Real bug - fixed in next 2.4 -ac tree

> drivers/usb/misc/auerswald.c:1556:		ret = copy_to_user(devinfo.buf, cp->dev_desc, u);

Real bug - fixed in next 2.4 -ac tree

> arch/sparc/kernel/sys_sunos.c:481:	ret = copy_to_user(&name->sname[0], &system_utsname.sysname[0], sizeof(name->sname) - 1);

Very broken.

> arch/sparc64/kernel/sys_sparc32.c:3675:	return copy_to_user(res32, kres, sizeof(*res32));

Looks very borked in several other spots

> arch/mips64/kernel/linux32.c:1537:	err |= __copy_from_user (p->mtext, &up->mtext, second);

Real bug - fixed in next 2.4 -ac tree

> arch/s390/kernel/debug.c:458:			if ((rc = copy_to_user(user_buf + count, 

This one is interesting - its not just a misunderstanding of the API also a
return of the wrong variable

> arch/s390/kernel/ptrace.c:119:			retval=copy_from_user((void *)realuseraddr,(void *)copyaddr,len);

Not a bug

> arch/s390/kernel/ptrace.c:345:		if((ret=copy_from_user(&parea,(void *)addr,sizeof(parea)))==0)  

Real bug - fixed in next 2.4 -ac tree

> arch/s390x/kernel/debug.c:458:			if ((rc = copy_to_user(user_buf + count, 

As per s390

> arch/s390x/kernel/ptrace.c:119:			retval = copy_from_user(realuserptr, copyptr, len);

Not a bug

> arch/s390x/kernel/ptrace.c:360:		if((ret=copy_from_user(&parea,(void *)addr,sizeof(parea)))==0)  

Real bug - fixed in the next 2.4 -ac tree


Alan
