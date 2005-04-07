Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262602AbVDGUy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbVDGUy4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 16:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbVDGUye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 16:54:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8127 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262600AbVDGUy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 16:54:28 -0400
Subject: Re: Kernel SCM saga..
From: Arjan van de Ven <arjan@infradead.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050407180412.GA31861@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	 <1112858331.6924.17.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0504070810270.28951@ppc970.osdl.org>
	 <20050407171006.GF8859@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0504071038320.28951@ppc970.osdl.org>
	 <20050407180412.GA31861@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Apr 2005 22:54:18 +0200
Message-Id: <1112907259.6290.81.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 8bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-07 at 20:04 +0200, Jörn Engel wrote:
> On Thu, 7 April 2005 10:47:18 -0700, Linus Torvalds wrote:
> > On Thu, 7 Apr 2005, Al Viro wrote:
> > > 
> > > No.  There's another reason - when you are cherry-picking and reordering
> > > *your* *own* *patches*.
> > 
> > Yes. I agree. There should be some support for cherry-picking in between a
> > temporary throw-away tree and a "cleaned-up-tree". However, it should be
> > something you really do need to think about, and in most cases it really
> > does boil down to "export as patch, re-import from patch". Especially
> > since you potentially want to edit things in between anyway when you
> > cherry-pick.
> 
> For reordering, using patcher, you can simply edit the sequence file
> and move lines around.  Nice and simple interface.
> 
> There is no checking involved, though.  If you mode dependent patches,
> you end up with a mess and either throw it all away or seriously
> scratch your head.  So a serious SCM might do something like this:


just fyi, patchutils has a tool that can "flip" the order of patches
even if they patch the same line of code in the files.... with it you
can make a "bubble sort" to move stuff about safely...


