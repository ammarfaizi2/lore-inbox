Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132029AbRAFTw6>; Sat, 6 Jan 2001 14:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132226AbRAFTws>; Sat, 6 Jan 2001 14:52:48 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58379 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132029AbRAFTwb>; Sat, 6 Jan 2001 14:52:31 -0500
Subject: Re: How to make VFAT work right in 2.4.0-prereleaseu
To: lubaldo@adinet.com.uy (Ivan Baldo)
Date: Sat, 6 Jan 2001 19:53:49 +0000 (GMT)
Cc: flf@operamail.com, ben@imben.com, edolstra@students.cs.uu.nl,
        linux-kernel@vger.kernel.org, linux-uy@linux.org.uy (Linux Uruguay),
        salvador@inti.gov.ar (SET)
In-Reply-To: <3A576837.34E90872@adinet.com.uy> from "Ivan Baldo" at Jan 06, 2001 03:47:19 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E14EzPU-0001SG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	- edit file fs/fat/inode.c, look in the function named
> "fat_notify_change" (at about line 901), where it says:"
> 	/* FAT cannot truncate to a longer file */
> 	if (attr->ia_valid & ATTR_SIZE) {
> 		if (attr->ia_size > inode->i_size)
> 			return -EPERM;
> 	}
> 	", just delete all of it (or comment it out). This change wich has been
> made in the -prerelease versión, makes Netscape Messenger not to work

If you do that you will corrupt your FAT fs. Very bad idea

> 	- apply attached patch made by Eelco Dolstra
> <edolstra@students.cs.uu.nl>, I am testing and using this patch since
> 13.nov.2000 (a lot of time) and with various versions of the Linux
> 2.4.0-testXX series kernels and it works flawlessly! Without it you get

2.4.0-ac has the truncate to grow stuff. It should just work out of the box.
Let me know if not


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
