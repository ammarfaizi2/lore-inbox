Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285963AbSAEABk>; Fri, 4 Jan 2002 19:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285965AbSAEAB3>; Fri, 4 Jan 2002 19:01:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45576 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285963AbSAEABU>; Fri, 4 Jan 2002 19:01:20 -0500
Subject: Re: 2.5.2-pre7 still missing bits of kdev_t
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 5 Jan 2002 00:10:42 +0000 (GMT)
Cc: viro@math.psu.edu (Alexander Viro), Andries.Brouwer@cwi.nl,
        Nikita@Namesys.COM, alessandro.suardi@oracle.com,
        jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201041311240.8047-100000@penguin.transmeta.com> from "Linus Torvalds" at Jan 04, 2002 01:14:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16MeQ6-00067o-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At that point it becomes a ABI issue how the mknod _system_call_ argument
> is split up into major/minor, and the rest of the kernel wouldn't really
> care.

You need a mknod2() system call assuming we want hotplug to be able to
create 32bit dev_t's. At the point glibc calls mknod its got an internal
32:32 representation so passing mknod2(char *,int,int) and making sure
mknod doesnt break if we expand further some years hence doesn't seem to 
be daft.

