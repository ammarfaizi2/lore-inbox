Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262713AbREOJpw>; Tue, 15 May 2001 05:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbREOJpm>; Tue, 15 May 2001 05:45:42 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:47118 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262710AbREOJpf>; Tue, 15 May 2001 05:45:35 -0400
Subject: Re: [PATCH] pcmcia/rsrc_mgr.c
To: victor.wong@stanford.edu (Victor Wong)
Date: Tue, 15 May 2001 10:41:21 +0100 (BST)
Cc: dhinds@users.sourceforge.net, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <NDBBLHPAGLNBKNHFNOOGCEHECKAA.victor.wong@stanford.edu> from "Victor Wong" at May 14, 2001 11:40:58 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zbKT-0002H0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following is a patch to the pcmcia code in which a kmalloc failure could
> cause the code to crash since the pointer is dereferenced. I've instead
> allocated the fixed sized array on the stack. The patch was made against

We intentionally keep large objects off the stack
