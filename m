Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317375AbSGISqL>; Tue, 9 Jul 2002 14:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317376AbSGISqJ>; Tue, 9 Jul 2002 14:46:09 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49924 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317375AbSGISpk>; Tue, 9 Jul 2002 14:45:40 -0400
Subject: Re: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine for directories on NFS mounts
To: root@chaos.analogic.com
Date: Tue, 9 Jul 2002 20:11:09 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
       trond.myklebust@fys.uio.no (Trond Myklebust), nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020709130055.377A-100000@chaos.analogic.com> from "Richard B. Johnson" at Jul 09, 2002 01:22:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17S0OD-0005UY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Really? Then what is the meaning of fsync() on a read-only file-
> descriptor? You can't update the information you can't change.

fsync ensures the data for that inode/file content is on stable storage - note
_the_ _data_ not only random things written by this specific file handle.
