Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267540AbSLSELL>; Wed, 18 Dec 2002 23:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267541AbSLSELL>; Wed, 18 Dec 2002 23:11:11 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:49168
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S267540AbSLSELJ>; Wed, 18 Dec 2002 23:11:09 -0500
Subject: Re: modules oops in 2.5.52
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021219024313.759EC2C075@lists.samba.org>
References: <20021219024313.759EC2C075@lists.samba.org>
Content-Type: text/plain
Organization: 
Message-Id: <1040271549.1317.12.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Dec 2002 20:19:09 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-18 at 18:11, Rusty Russell wrote:
> In message <1040260444.1316.4.camel@ixodes.goop.org> you write:
> > Hi,
> > 
> > I just had an oops in the modules code:
> > 
> > Dec 18 16:58:59 ixodes kernel: Unable to handle kernel paging request at virt
> ual address f8980924
> > Dec 18 16:58:59 ixodes kernel:  printing eip:
> > Dec 18 16:58:59 ixodes kernel: f896756d
> > Dec 18 16:58:59 ixodes kernel: *pde = 01bfc067
> > Dec 18 16:58:59 ixodes kernel: *pte = 00000000
> > Dec 18 16:58:59 ixodes kernel: Oops: 0000
> > Dec 18 16:58:59 ixodes kernel: CPU:    0
> > Dec 18 16:58:59 ixodes kernel: EIP:    0060:[<f896756d>]    Not tainted
> > Dec 18 16:58:59 ixodes kernel: EFLAGS: 00010282
> > Dec 18 16:58:59 ixodes kernel: EIP is at __exitfn+0xd/0x4c [parport_pc]
> 
> Actually, you had an oops in the parport_pc code, in
> cleanup_module().  Now, *why* that oopsed, I don't know...

It looks like it might end up calling request_module() from within
cleanup_module(). Is that going to be a problem?
        
        J

