Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbTE3PAC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 11:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263737AbTE3PAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 11:00:02 -0400
Received: from aneto.able.es ([212.97.163.22]:38137 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S263731AbTE3PAA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 11:00:00 -0400
Date: Fri, 30 May 2003 17:13:17 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Margit Schubert-While <margitsw@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: drivers/char/sysrq.c
Message-ID: <20030530151317.GA3973@werewolf.able.es>
References: <5.1.0.14.2.20030530164138.00aeee40@pop.t-online.de> <20030530145851.GA15640@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030530145851.GA15640@wohnheim.fh-wedel.de>; from joern@wohnheim.fh-wedel.de on Fri, May 30, 2003 at 16:58:51 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.30, Jörn Engel wrote:
> On Fri, 30 May 2003 16:44:55 +0200, Margit Schubert-While wrote:
> > 
> > In drivers/char/sysrq.c (2.4 and 2.5) we have :
> > 
> >         if ((key >= '0') & (key <= '9')) {
> >                 retval = key - '0';
> >         } else if ((key >= 'a') & (key <= 'z')) {
> > 
> > Shouldn't the "&" be (pedantically) "&&" ?
> 
> It is semantically the same.  If you can show that gcc optimization
> also creates the same assembler code, few people will object to a
> patch.
> 

I see a diff:
- & is bitwise and you always perform the op
- && is logical and gcc must shortcut it

I think people use & 'cause they prefer the extra argument calculation
than the branch for the shortcut (AFAIR...)

or not ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-rc6-jam1 (gcc 3.2.3 (Mandrake Linux 9.2 3.2.3-1mdk))
