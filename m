Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136719AbREAVID>; Tue, 1 May 2001 17:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136727AbREAVHx>; Tue, 1 May 2001 17:07:53 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:524 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136719AbREAVHn>; Tue, 1 May 2001 17:07:43 -0400
Subject: Re: Maximum files per Directory
To: lu01@rogge.yi.org (Andreas Rogge)
Date: Tue, 1 May 2001 22:02:31 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <272800000.988750082@hades> from "Andreas Rogge" at May 01, 2001 10:48:02 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uhI2-0002NH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> cyrus-imapd i ran into problems.
> At about 2^15 files the filesystem gave up, telling me that there cannot be
> more files in a directory.
> 
> Is this a vfs-Issue or an ext2-issue?

Bit of both. You exceeded the max link count, and your performance would have
been abominable too. cyrus should be using heirarchies of directories for
very large amounts of stuff.
