Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314095AbSEMQUt>; Mon, 13 May 2002 12:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314136AbSEMQUs>; Mon, 13 May 2002 12:20:48 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:35508 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S314095AbSEMQUo>; Mon, 13 May 2002 12:20:44 -0400
Date: Mon, 13 May 2002 12:19:33 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Strange s390 code in 2.4.19-pre8
Message-ID: <20020513121933.A6208@devserv.devel.redhat.com>
In-Reply-To: <OFFA479633.3A335CB7-ONC1256BB8.002ABB8D@de.ibm.com> <Pine.LNX.4.44.0205131114420.19498-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Mon, 13 May 2002 11:16:07 -0500 (CDT)
> From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>

> > > #2 - strange changes to net Makefile
> > The intention of this is to have fsm.o built as a module if ctc
> > and iucv are built as modules too. I agree that this is broken
> > if one of {iucv,ctc} is built as a module and the other is built
> > in.
> 
> Actually, I don't think it's broken, Rules.make takes care of that case 
> and compiles fsm.o into the kernel in the latter case, it does not build 
> a fsm.o module.
> 
> --Kai

Obviously, the guy who did the change expected it to work
like you described, but he never tested it, and it doesn't.
ctc fails to load with init_fsm undefined.
It would work if EXPORT_SYMBOL_NOVERS were involved.

-- Pete
