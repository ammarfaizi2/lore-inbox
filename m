Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317180AbSGNWCD>; Sun, 14 Jul 2002 18:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317181AbSGNWCC>; Sun, 14 Jul 2002 18:02:02 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:26870 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317180AbSGNWCB>; Sun, 14 Jul 2002 18:02:01 -0400
Subject: Re: BUG: pdcraid OOPS due to uninitialized variable access
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
Cc: linux-kernel list <linux-kernel@vger.kernel.org>,
       Juan Quintela <quintela@mandrakesoft.com>,
       Cooker list <cooker@linux-mandrake.com>
In-Reply-To: <1026668086.3181.3.camel@localhost.localdomain>
References: <1026668086.3181.3.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 Jul 2002 00:11:12 +0100
Message-Id: <1026688272.13886.92.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-14 at 18:34, Borsenkow Andrej wrote:
> On both 2.4.18-6mdk (from 8.2) and in current cooker pdcraid oopses
> immediately after insertion. The reason is usage of uninitialized
> variable in drivers/ide/pdcraid.c:
> 
> I am sorry, I do not have vanilla kernel so I cannot check if bug is in
> general kernel or Mandrake-specific.

This appears to be broken vendor specific hack. This code doesn't appear
in the base pdcraid code. I guess they tried to make the autodetect more
accurate and got it wrong. It would be interesting to know what the goal
was and why it wasnt posted to the maintainers ?

Alan

