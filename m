Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315806AbSENQXV>; Tue, 14 May 2002 12:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315807AbSENQXU>; Tue, 14 May 2002 12:23:20 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55302 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315806AbSENQXS>; Tue, 14 May 2002 12:23:18 -0400
Subject: Re: File open/create attibutes.
To: root@chaos.analogic.com
Date: Tue, 14 May 2002 17:43:03 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux kernel)
In-Reply-To: <Pine.LNX.3.95.1020514113724.2711A-100000@chaos.analogic.com> from "Richard B. Johnson" at May 14, 2002 11:44:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E177fOB-0008H5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If a file exists with attributes, 0644, and it is opened with truncate
> and create with different attributes, it doesn't get those attributes.
> It's only if the file doesn't exist at all that it gets created with
> the new attributes.

This is correct behaviour. See IEEE Std 1003.1-2001. Its explicitly 
specified that "If the file exists and is a regular file, and the file
is successfully opened O_RDWR or O_WRONLY, its length shall be truncated
to 0, and the mode and owner shall be unchanged"
