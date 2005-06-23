Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbVFWOc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbVFWOc3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 10:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVFWOc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 10:32:29 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:27806 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262547AbVFWOcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 10:32:22 -0400
Message-Id: <200506231431.j5NEVvpK004472@laptop11.inf.utfsm.cl>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers 
In-Reply-To: Message from Jeff Garzik <jgarzik@pobox.com> 
   of "Thu, 23 Jun 2005 01:16:33 -0400." <42BA45B1.7060207@pobox.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Thu, 23 Jun 2005 10:31:57 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 23 Jun 2005 10:31:58 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> said:
> Linus Torvalds wrote:
> > 	rsync -r --ignore-existing repo/refs/tags/ .git/refs/tags/
> > 
> > See? What's your complaint with just doing that?
> 
> No complaint with that operation.  The complaint is that it's an 
> additional operation.  Re-read what Greg said:
> 
> > Is there some reason why git doesn't pull the
> > tags in properly when doing a merge?  Chris and I just hit this when I
> > pulled his 2.6.12.1 tree and and was wondering where the tag went.
> 
> Multiple users -- not just me -- would prefer that git-pull-script 
> pulled the tags, too.
> 
> Suggested solution:  add '--tags' to git-pull-script 
> (git-fetch-script?), which calls
> 	rsync -r --ignore-existing repo/refs/tags/ .git/refs/tags/

I don't think either is really a solution. IMHO there should be a
distinction between "official tags" (that get passed around together with
everything else) and "private tags" for everybodys own home use (that could
be passed around, but only explicitly). Plus the possibility to erase,
move, &c private tags, and perhaps upgrade them to official status (thus
setting them in stone).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
