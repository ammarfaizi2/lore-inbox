Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbQJ3Tac>; Mon, 30 Oct 2000 14:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129043AbQJ3TaX>; Mon, 30 Oct 2000 14:30:23 -0500
Received: from 134-ZARA-X27.libre.retevision.es ([62.82.240.134]:28428 "EHLO
	head.redvip.net") by vger.kernel.org with ESMTP id <S129026AbQJ3TaJ>;
	Mon, 30 Oct 2000 14:30:09 -0500
Message-ID: <39FD5433.587FF7C6@zaralinux.com>
Date: Mon, 30 Oct 2000 11:57:55 +0100
From: Jorge Nerin <comandante@zaralinux.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: es-ES, es, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, pavel rabel <pavel@web.sajt.cz>,
        linux-net@vger.kernel.org, p_gortmaker@yahoo.com, netdev@oss.sgi.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] NE2000
In-Reply-To: <E13pz9c-0006Jh-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > This change sounds ok to me, if noone else objects.  (I added to the CC
> > a bit)  I saw that code, and was thinking about doing the same thing
> > myself.  ne2k-pci.c definitely has changes which are not included in
> > ne.c, and it seems silly to duplicate ne2000 PCI support.
> 
> Unless there are any cards that need the bug workarounds in ne.c for use
> on PCI then I see no problem. I've not heard of any.
> 

Ok, I reported it several times, but it gets ignored. I have a Realtek
8029 (ne2k-pci), and with both drivers ne and ne2k-pci I can easily get
it stuck by doing a ping -f to a host in the local net, and sometimes it
happens doing copies to/from nfs shared resources.

rmmod & insmod don't cure the problem, it seems that no interrupts are
delivered from the card, and there are no log messages, so a reboot is
needed to restore net access.

System is dual 2x200mmx 96Mb ide discs no interrupts shared, and as far
as I can remember all kernel from 2.2.x, 2.3.x up to 2.4.0-testx exhibit
this problem.

-- 
Jorge Nerin
<comandante@zaralinux.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
