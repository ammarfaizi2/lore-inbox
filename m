Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751963AbWG0Tbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbWG0Tbm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 15:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbWG0Tbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 15:31:42 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:35803 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751961AbWG0Tbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 15:31:41 -0400
Message-Id: <200607271930.k6RJUQ6s016546@laptop13.inf.utfsm.cl>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Petr Baudis <pasky@suse.cz>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       alan@lxorguk.ukuu.org.uk, tytso@mit.edu, tigran@veritas.com
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2 
In-Reply-To: Message from Pekka Enberg <penberg@cs.helsinki.fi> 
   of "Thu, 27 Jul 2006 21:10:36 +0300." <1154023836.7190.3.camel@ubuntu> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Thu, 27 Jul 2006 15:30:26 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Thu, 27 Jul 2006 15:30:32 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> On Thu, 2006-07-27 at 20:06 +0200, Petr Baudis wrote:
> > Make that setuid root or just create log file owned by you and make root
> > run it.  Should be innocent enough, right?
> > 
> > Well, except that you can revoke the log file before the shadow file is
> > opened, at which point open() probably reuses the fd and the program
> > conveniently logs to /etc/shadow.

> No, the fd is leaked on purpose to avoid recycling. See revoke_fds for
> details.

Doesn't that violate a POSIX guarantee that the lowest unused fd is
returned? If the leakage lasts "long enough", this gives an opportunity of
a nice DoS by using up fds...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

