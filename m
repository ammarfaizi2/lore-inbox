Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314101AbSEMQTi>; Mon, 13 May 2002 12:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314106AbSEMQTb>; Mon, 13 May 2002 12:19:31 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:20119 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S314101AbSEMQSY>; Mon, 13 May 2002 12:18:24 -0400
Date: Mon, 13 May 2002 11:18:22 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Strange s390 code in 2.4.19-pre8
In-Reply-To: <20020513121008.B29935@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0205131116440.19498-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2002, Pete Zaitcev wrote:

> The old Makefile was correct, and the only failing was a namespace
> conflict between your fsm.c and fsm.c in ISDN, when CONFIG_MODVERSIONS
> are used. The right fix is to rename your fsm.c or to create
> fsm_s390_ksyms.c with all EXPORT_SYMBOL's sitting in there.
> It is fixed in 2.5 with $(MODPREFIX) in Rules.make.

It's easily possible to backport the 2.5 Rules.make change to 2.4, so the 
file doesn't have to be renamed - if you want me to do that, let me know.

--Kai


