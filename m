Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129168AbQJ2UJU>; Sun, 29 Oct 2000 15:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129134AbQJ2UJL>; Sun, 29 Oct 2000 15:09:11 -0500
Received: from mail0.atl.bellsouth.net ([205.152.0.27]:40876 "EHLO
	mail0.atl.bellsouth.net") by vger.kernel.org with ESMTP
	id <S129168AbQJ2UI5>; Sun, 29 Oct 2000 15:08:57 -0500
Message-ID: <39FC83CD.B10BF08D@mandrakesoft.com>
Date: Sun, 29 Oct 2000 15:08:45 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: pavel rabel <pavel@web.sajt.cz>
CC: linux-net@vger.kernel.org, p_gortmaker@yahoo.com, netdev@oss.sgi.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] NE2000
In-Reply-To: <Pine.LNX.4.21.0010300344130.6792-100000@web.sajt.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pavel rabel wrote:
> There are three drivers for n2k cards. One is MCA only, one is PCI only,
> and the then the third one (ne.c) is both ISA and PCI. I think the ISA
> driver should be ISA only, as is described in Documentation and in config
> help. So I removed PCI code from ne.c to have ISA only driver. It
> gets a bit smaller, although I am not sure whether more code can be
> removed.

This change sounds ok to me, if noone else objects.  (I added to the CC
a bit)  I saw that code, and was thinking about doing the same thing
myself.  ne2k-pci.c definitely has changes which are not included in
ne.c, and it seems silly to duplicate ne2000 PCI support.

Regards,

	Jeff


P.S.  Pavel, for the future, patches made with "diff -u" are preferred.

-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
