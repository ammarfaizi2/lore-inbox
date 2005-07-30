Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262955AbVG3N2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbVG3N2K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 09:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbVG3N2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 09:28:10 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:36017 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S262955AbVG3N2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 09:28:02 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH] swsusp: simpler calculation of number of pages in PBE list
Date: Sat, 30 Jul 2005 15:32:58 +0200
User-Agent: KMail/1.8.1
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0507292126390.16749-100000@netrider.rowland.org> <200507301516.32003.rjw@sisk.pl> <20050730131356.GE1830@elf.ucw.cz>
In-Reply-To: <20050730131356.GE1830@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507301532.59576.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday, 30 of July 2005 15:13, Pavel Machek wrote:
> Hi!
> 
> > > 	px >= n + x
> > > 
> > > or
> > > 
> > > 	(p-1)x >= n
> > > 
> > > or
> > > 
> > > 	x >= n / (p-1).
> > > 
> > > The obvious solution is
> > > 
> > > 	x = ceiling(n / (p-1)),
> > > 
> > > so calc_nr should return n + ceiling(n / (p-1)), which is exactly what 
> > > Michal's patch computes.
> > 
> > Nice. :-)
> > 
> > Could we perhaps add your proof to the Michal's patch as a comment,
> > for reference?
> 
> No, thanks. It only proves that it is equivalent to old code, but says
> nothing about quality of code, and we really do not want to keep old
> code around.

IMHO it rather says that the formula is OK and would save some time to
people reading the code for the _first_ time and trying to understand it,
but you decide. :-)

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
