Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289813AbSCOMxE>; Fri, 15 Mar 2002 07:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292087AbSCOMwx>; Fri, 15 Mar 2002 07:52:53 -0500
Received: from ns.suse.de ([213.95.15.193]:52749 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289813AbSCOMwl>;
	Fri, 15 Mar 2002 07:52:41 -0500
Date: Fri, 15 Mar 2002 13:52:40 +0100
From: Andi Kleen <ak@suse.de>
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: IO delay, port 0x80, and BIOS POST codes
Message-ID: <20020315135240.A5979@wotan.suse.de>
In-Reply-To: <p73lmcuyrov.fsf@oldwotan.suse.de> <Pine.LNX.4.33.0203151347110.1477-100000@biker.pdb.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0203151347110.1477-100000@biker.pdb.fsc.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 01:47:39PM +0100, Martin Wilck wrote:
> On 15 Mar 2002, Andi Kleen wrote:
> 
> > > It doesn't even have to be a config option - a line
> > >
> > > /* Port used for dummy writes for I/O delays */
> > > /* Change this only if you know what you're doing ! */
> > > #define DUMMY_IO_PORT 0x80
> > >
> > > in a header file would perfectly suffice.
> >
> > That effectively already exists. You just need to change the __SLOW_DOWN_IO
> > macro in include/asm-i387/io.h
> 
> No, that doesn't cover all accesses to port 80. I am still searching.

It should. I would consider all other accesses a bug.
It is possible that some driver used it for private debugging and left it in by 
mistake. These should be removed.

-Andi
