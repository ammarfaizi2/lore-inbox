Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266160AbUAGJgC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 04:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266159AbUAGJgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 04:36:02 -0500
Received: from gonzo.one-2-one.net ([217.115.142.69]:15367 "EHLO
	gonzo.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S266156AbUAGJfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 04:35:51 -0500
Date: Wed, 7 Jan 2004 10:28:32 +0100
From: stefan.eletzhofer@eletztrick.de
To: linux-kernel@vger.kernel.org
Subject: Re: Syscall table AKA hijacking syscalls
Message-ID: <20040107092832.GA450@gonzo.local>
Reply-To: stefan.eletzhofer@eletztrick.de
Mail-Followup-To: stefan.eletzhofer@eletztrick.de,
	linux-kernel@vger.kernel.org
References: <3FF56B1C.1040308@conet.cz> <20040102151206.GJ1718@actcom.co.il> <3FF59073.3060305@conet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF59073.3060305@conet.cz>
User-Agent: Mutt/1.3.27i
Organization: Eletztrick Computing
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 04:38:27PM +0100, Libor Vanek wrote:
> 
> >>I'm writing some project which needs to hijack some syscalls in VFS 
> >>layer. AFAIK in 2.6 is this "not-wanted" solution (even that there are 
> >>some very nasty ways of doing it - see 
> >>http://mail.nl.linux.org/kernelnewbies/2002-12/msg00266.html )
> >>   
> >>
> >
> >Why do you need to hijack system calls from a module? 99% of the
> >times, it's the wrong technical solution. 
> > 
> >
> I'm working on my diploma thesis which is adding snapshot capability 
> into Linux VFS (so you can do directory based snapshots - not complete 
> device, like in LVM). It'll consist of two separete modules:
> Snapshot module:
> - will hijack (one or another way) calls to open/move/unlink/mkdir/etc. 
> syscall
> - when will detect change to selected directory (which I want to 
> snapshot), it'll copy/move old file/directory to some temporary 
> (selected when creating snapshot) - in fact - copy on write behaviour

Do it in userspace. Hack a nfs server.

> 
> UnionFS module:
> - will place "temporary" directory with saved files/dirs "over" actual 
> one and result will be read-only snapshot - this can be done without 
> hijacking syscalls probably
> - something like overlay fs but a bit different
> 
> -- 
> 
> Libor Vanek
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Eletztrick Computing - Customized Linux Development
Stefan Eletzhofer, Marktstrasse 43, DE-88214 Ravensburg
http://www.eletztrick.de
