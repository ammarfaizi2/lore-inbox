Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131349AbRDBVou>; Mon, 2 Apr 2001 17:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131352AbRDBVok>; Mon, 2 Apr 2001 17:44:40 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26897 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131349AbRDBVoc>; Mon, 2 Apr 2001 17:44:32 -0400
Subject: Re: Larger dev_t
To: Andries.Brouwer@cwi.nl
Date: Mon, 2 Apr 2001 22:45:03 +0100 (BST)
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, hpa@transmeta.com,
   linux-kernel@vger.kernel.org, tytso@MIT.EDU
In-Reply-To: <UTC200104022017.WAA89061.aeb@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl" at Apr 02, 2001 10:17:02 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kC8N-0006nc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not using 64 also gives interesting small problems with Solaris or
> FreeBSD NFS mounts. One uses 14+18, the other 8+24, so with 12+20
> we cannot handle Solaris' majors and we cannot handle FreeBSD's minors.

Mount NFS device areas with NFSv2. Thats the standard workaround for the
fact the NFSv3 designers got a good idea slightly wrong. There are other
approaches too that also do not need 64bits.
