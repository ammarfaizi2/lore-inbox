Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTEHVgP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 17:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbTEHVgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 17:36:15 -0400
Received: from aneto.able.es ([212.97.163.22]:42229 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262153AbTEHVgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 17:36:13 -0400
Date: Thu, 8 May 2003 23:48:11 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Christoph Hellwig <hch@infradead.org>
Cc: Shachar Shemesh <lkml@shemesh.biz>,
       Terje Eggestad <terje.eggestad@scali.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chuck Ebbert <76306.1226@compuserve.com>, D.A.Fedorov@inp.nsk.su,
       Steffen Persvold <sp@scali.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030508214811.GC3458@werewolf.able.es>
References: <200305071507_MC3-1-37CF-FE32@compuserve.com> <1052387912.4849.43.camel@pc-16.office.scali.no> <20030508095943.B22255@devserv.devel.redhat.com> <1052398474.4849.57.camel@pc-16.office.scali.no> <20030508135839.A6698@infradead.org> <3EBAAB9D.5000508@shemesh.biz> <20030508201509.A19496@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030508201509.A19496@infradead.org>; from hch@infradead.org on Thu, May 08, 2003 at 21:15:09 +0200
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.08, Christoph Hellwig wrote:
> On Thu, May 08, 2003 at 10:10:21PM +0300, Shachar Shemesh wrote:
> > Christoph Hellwig wrote:
> > 
> > >Maybe you have a different notion of proper mechanism then everyone
> > >else.
> > >
> > Out of personal interest - would a mechanism that promised the following 
> > be considered a "proper mechanism"?
> > 1. Work on all platforms.
> > 2. Allow load and unload in arbitrary order and timings (which also 
> > means "be race free").
> > 3. Have low/zero overhead if not used
> 
> No, the most important point is that a proper meachanism wouldn't
> replace syscall slots but rather operate on kernel objects (file, inode
> vma, task_struct, etc..).  Linus has expressed a few times that
> he has no interest in loadable syscalls and any core developer I've
> talked to agrees with that.
> 

Don't have followed the whole thread, so I don't know if somebody has already
said this, but all this thing about hooks looks perfect for projects like
bproc or mosix, have you talked to them ?
(perhaps Erik Hendriks <erik@hendriks.cx> -bproc- is following the thread...;) )

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-rc1-jam2 (gcc 3.2.2 (Mandrake Linux 9.2 3.2.2-5mdk))
