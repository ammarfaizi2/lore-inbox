Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274077AbRJBNm7>; Tue, 2 Oct 2001 09:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274034AbRJBNmk>; Tue, 2 Oct 2001 09:42:40 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4871 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274035AbRJBNme>; Tue, 2 Oct 2001 09:42:34 -0400
Subject: Re: NFSv3 and linux-2.4.10-ac3 => oops
To: matt@theBachChoir.org.uk (Matt Bernstein)
Date: Tue, 2 Oct 2001 14:47:09 +0100 (BST)
Cc: trond.myklebust@fys.uio.no (Trond Myklebust),
        hpa@transmeta.com (H. Peter Anvin), alan@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0110021227340.31037-100000@nick.dcs.qmul.ac.uk> from "Matt Bernstein" at Oct 02, 2001 12:32:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15oPt7-0004gA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wonder if this is related to oopses I sent in in the last two days?
> We're running 4GB setups with NFSv3 client and server on our fileservers,
> and the oopses might (don't really have strong correlation evidence yet)
> be related to when our fileservers push online backups to cheaper NFS
> servers (running the same kernel based on 2.4.9-ac10). Is there a last
> known good kernel I can try on my production systems while I try to
> reproduce the problem on smaller boxes? Or would you like me to try your
> patch?

Are these oopses new as of the 2.4.10 based tree. If so do you see them 
with 2.4.10-ac3 ?

Right now we have a sort of bug candidate set that is

		VM	NFS	LOCKING
2.4.9-ac10	old	old	old
2.4.9-ac16	new	old	old
2.4.9-ac18	new	old	half-way
2.4.10-ac3	new	new	new

that may help deduce which problem

Alan
