Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314929AbSEHTZy>; Wed, 8 May 2002 15:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314938AbSEHTZx>; Wed, 8 May 2002 15:25:53 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11282 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314929AbSEHTZx>; Wed, 8 May 2002 15:25:53 -0400
Subject: Re: [PATCH] 2.5.14 IDE 56
To: andersen@codepoet.org
Date: Wed, 8 May 2002 20:31:11 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        dalecki@evision-ventures.com (Martin Dalecki),
        torvalds@transmeta.com (Linus Torvalds),
        padraig@antefacto.com (Padraig Brady),
        aia21@cantab.net (Anton Altaparmakov),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <20020508182139.GA22659@codepoet.org> from "Erik Andersen" at May 08, 2002 12:21:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E175X9b-0002D0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> int i, type, major=0, minor=0;
> for(i=0; i<26; i++) {
>     snprintf(device_string, sizeof(device_string), "/dev/hd%c", 'a'+i);
>     if ((fd=open(device_string, O_RDONLY | O_NONBLOCK)) < 0) {
> 	continue;
>     }

If it opened is it there. Suppose its an IDE floppy and no media is 
present. Maybe its hiding in ide-scsi instead.  It ends up being detective
work. The /device set up makes it explicit and clean
