Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317464AbSFRQCt>; Tue, 18 Jun 2002 12:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317465AbSFRQCr>; Tue, 18 Jun 2002 12:02:47 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:23936 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S317464AbSFRQCP>; Tue, 18 Jun 2002 12:02:15 -0400
Date: Tue, 18 Jun 2002 18:08:28 +0200
Organization: Pleyades
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Shrinking ext3 directories
Message-ID: <3D0F5AFC.mailGSE111D9L@viadomus.com>
User-Agent: nail 9.31 6/18/02
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :))

    All of you know that if you create a lot of files or directories
within a directory on ext2/3 and after that you remove them, the
blocks aren't freed (this is the reason behind the lost+found block
preallocation). If you want to 'shrink' the directory now that it
doesn't contain a lot of leafs, the only solution I know is creating
a new directory, move the remaining leafs to it, remove the
'big-unshrinken' directory and after that renaming the new directory:

    $ mkdir new-dir
    $ mv bigone/* new-dir/
    $ rmdir bigone
    $ mv new-dir bigone
    (Well, sort of)

    Any other way of doing the same without the mess?

    Thanks a lot :)
    Raúl
