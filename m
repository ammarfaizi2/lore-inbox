Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315528AbSGANTl>; Mon, 1 Jul 2002 09:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315529AbSGANTk>; Mon, 1 Jul 2002 09:19:40 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:59918 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S315528AbSGANTj>; Mon, 1 Jul 2002 09:19:39 -0400
Message-Id: <200207011316.g61DGxT18808@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: willy tarreau <wtarreau@yahoo.fr>, Willy TARREAU <willy@w.ods.org>,
       willy@meta-x.org, linux-kernel@vger.kernel.org,
       Ronald.Wahl@informatik.tu-chemnitz.de
Subject: Re: [ANNOUNCE] CMOV emulation for 2.4.19-rc1
Date: Mon, 1 Jul 2002 16:16:44 -0200
X-Mailer: KMail [version 1.3.2]
References: <20020701130327.38962.qmail@web20506.mail.yahoo.com>
In-Reply-To: <20020701130327.38962.qmail@web20506.mail.yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 July 2002 11:03, willy tarreau wrote:
> Hello Denis,
>
> > This code is performance critical.
> > With this in mind,
>
> Yes and no. In fact, I first wanted to code some
> parts in assembler because GCC is sub-optimal
> on bit-fields calculations. But then, I realized that
> I could save, say 10 cycles, while the trap costs
> about 400 cycles.

Can you code up a "dummy" emulator (which just ignores
any invalid opcode by doing eip+=3) and compare trap times
of your emulator and dummy one for, say, CMOVC AL,AL?
(with carry flag cleared)
--
vda
