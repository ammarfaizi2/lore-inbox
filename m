Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314132AbSEMQYh>; Mon, 13 May 2002 12:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314136AbSEMQYh>; Mon, 13 May 2002 12:24:37 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:54711 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S314132AbSEMQYe>; Mon, 13 May 2002 12:24:34 -0400
Date: Mon, 13 May 2002 12:23:30 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Strange s390 code in 2.4.19-pre8
Message-ID: <20020513122330.B6208@devserv.devel.redhat.com>
In-Reply-To: <20020513121008.B29935@devserv.devel.redhat.com> <Pine.LNX.4.44.0205131116440.19498-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Mon, 13 May 2002 11:18:22 -0500 (CDT)
> From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>

> > The old Makefile was correct, and the only failing was a namespace
> > conflict between your fsm.c and fsm.c in ISDN, when CONFIG_MODVERSIONS
> > are used. The right fix is to rename your fsm.c or to create
> > fsm_s390_ksyms.c with all EXPORT_SYMBOL's sitting in there.
> > It is fixed in 2.5 with $(MODPREFIX) in Rules.make.
> 
> It's easily possible to backport the 2.5 Rules.make change to 2.4, so the 
> file doesn't have to be renamed - if you want me to do that, let me know.

Keith said to rename such things. Another easy thing to do
would be to move EXPORT_SYMBOL into s390_ksyms.c, under
#ifdef CONFIG_FSM_something. I understand that renaming
creates a diff with 100% change, so damage can easily
be slipped in, and then it's a hell to investigate.
[Let's see if a well known persona uses it as an excuse
for more commercial advertising of a certain software product].

-- Pete
