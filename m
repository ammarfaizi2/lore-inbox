Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314223AbSEMQaM>; Mon, 13 May 2002 12:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314228AbSEMQaL>; Mon, 13 May 2002 12:30:11 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:30615 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S314223AbSEMQaJ>; Mon, 13 May 2002 12:30:09 -0400
Date: Mon, 13 May 2002 11:30:06 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Strange s390 code in 2.4.19-pre8
In-Reply-To: <20020513122330.B6208@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0205131125250.19498-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2002, Pete Zaitcev wrote:

> Keith said to rename such things. Another easy thing to do
> would be to move EXPORT_SYMBOL into s390_ksyms.c, under
> #ifdef CONFIG_FSM_something. I understand that renaming
> creates a diff with 100% change, so damage can easily
> be slipped in, and then it's a hell to investigate.

No, putting the EXPORT_SYMBOL into s390_ksyms.c won't work for fsm.o being 
a module. Renaming has the obvious disadvantage that the module name 
changes as well.

I think I see two easy way to resolve the problem:
o backport the Rules.make change (it's been in 2.5 for months w/o even
  anybody noticing it, so it's definitely stable)
o Move the EXPORT_SYMBOL() in drivers/isdn/hisax/fsm.o into
  drivers/isdn/hisax/config.o

--Kai


> [Let's see if a well known persona uses it as an excuse
> for more commercial advertising of a certain software product].

;-)

