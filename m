Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751786AbWIRPio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbWIRPio (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 11:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWIRPio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 11:38:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:56965 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751786AbWIRPin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 11:38:43 -0400
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 18 Sep 2006 17:38:37 +0200
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
In-Reply-To: <200609181631.10625.ak@suse.de>
Message-ID: <20060918153837.263210@gmx.net>
MIME-Version: 1.0
References: <002801c6db2d$67d8a3a0$294b82ce@stuartm>
 <200609181631.10625.ak@suse.de>
Subject: Re: TCP stack behaviour question
To: Andi Kleen <ak@suse.de>, stuartm@connecttech.com
X-Authenticated: #24879014
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Von: Andi Kleen <ak@suse.de>
> On Monday 18 September 2006 16:19, Stuart MacDonald wrote:
> > From: Andi Kleen [mailto:ak@suse.de] 
> > > > # man 7 ip
> > > > ..
> > > >                Note that TCP has no error queue; MSG_ERRQUEUE is
> > > > illegal on SOCK_STREAM sockets.  Thus all errors are returned by
> > > > socket function return or SO_ERROR only.
> > > > 
> > > > Maybe the man page is wrong? That's from my FC 3 install.
> > > 
> > > The sentence is correct, but TCP has a IP_RECVERR that works
> > > differently without a queue. Basically it doesn't delay the error 
> > > reporting for incoming ICMPs to the last retransmit, but reports
> > > them immediately. This is documented in tcp(7)
> > 
> > I read that too, but didn't know which one was correct, so I erred on
> > the side of caution and believed ip(7).
> 
> Ok maybe it's a bit misleading. Michael, you might want to clarify.

Can some one of you propose a better text please?

Cheers,

Michael
-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
