Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264812AbTFBRmq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 13:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264814AbTFBRmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 13:42:46 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:44508 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP id S264812AbTFBRmp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 13:42:45 -0400
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function
	declarations.
From: Steven Cole <elenstev@mesatop.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Juan Quintela <quintela@mandrakesoft.com>,
       Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20030602173450.GD9312@conectiva.com.br>
References: <Pine.LNX.4.44.0306020856450.19910-100000@home.transmeta.com>
	 <1054571980.3751.141.camel@spc9.esa.lanl.gov>
	 <20030602173450.GD9312@conectiva.com.br>
Content-Type: text/plain
Organization: 
Message-Id: <1054576546.3751.146.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 02 Jun 2003 11:55:47 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-02 at 11:34, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jun 02, 2003 at 10:39:41AM -0600, Steven Cole escreveu:
> > On Mon, 2003-06-02 at 09:59, Linus Torvalds wrote:
> > > On 2 Jun 2003, Juan Quintela wrote:
> > > > 
> > > > /**
> > > >  * foo - <put something there>
> > > >  * @bar: number of frobnicators
> > > >  * @baz: self-larting on or off
> > > >  * @userdata: pointer to arbitrary userdata to be registered
> > > >  *
> > > >  * Description: Please, fix me
> > > >  */
> > > > int foo(long bar, long baz)
> > > > {
> > > > ...
> > > > 
> > > > Looks like a better alternative to me.
> > > 
> > > Hey, if somebody were to send me a patch (hint hint), I'd happily apply 
> > > it.
> > > 
> > > 		Linus
> > 
> > I sent this last night as an example, except now the function
> > declaration is not wrapped.  How is this?
> > 
> > Steven
> > 
> > --- linux/lib/zlib_inflate/inftrees.c.orig	Mon Jun  2 10:15:29 2003
> > +++ linux/lib/zlib_inflate/inftrees.c	Mon Jun  2 10:16:47 2003
> > @@ -288,14 +288,16 @@
> >    return y != 0 && g != 1 ? Z_BUF_ERROR : Z_OK;
> > +int zlib_inflate_trees_bits(uIntf *c, uIntf *bb, inflate_huft * FAR *tb, inflate_huft *hp, z_streamp z)
> >  {
> >    int r;
> >    uInt hn = 0;          /* hufts used in space */
> 
> I do it like this:
> 
> 
> int zlib_inflate_trees_bits(uIntf *c, uIntf *bb, inflate_huft * FAR *tb,
> 			    inflate_huft *hp, z_streamp z)
> 
> - Arnaldo

For zlib, here is a worst case, with three choices, and there may be
others since style is quite a matter of taste.

local int huft_build(uIntf *b, uInt n, uInt s, const uIntf *d, const uIntf *e,
		     inflate_huft * FAR *t, uIntf *m, inflate_huft *hp, uInt *hn, uIntf *v)

local int huft_build(uIntf *b, uInt n, uInt s, const uIntf *d, const uIntf *e,
	inflate_huft * FAR *t, uIntf *m, inflate_huft *hp, uInt *hn, uIntf *v)

local int huft_build(uIntf *b, uInt n, uInt s, const uIntf *d, const uIntf *e, inflate_huft * FAR *t, uIntf *m, inflate_huft *hp, uInt *hn, uIntf *v)

Steven


