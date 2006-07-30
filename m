Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWG3TbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWG3TbO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 15:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWG3TbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 15:31:14 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:65242 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932444AbWG3TbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 15:31:13 -0400
Date: Sun, 30 Jul 2006 21:31:13 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: hardcode value of YACC&LEX for aic7-triple-x
Message-ID: <20060730193113.GB31690@mars.ravnborg.org>
References: <20060729071540.GA6738@mars.ravnborg.org> <11541575812597-git-send-email-sam@ravnborg.org> <20060729090725.GF6843@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060729090725.GF6843@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 01:07:25PM +0400, Alexey Dobriyan wrote:
> On Sat, Jul 29, 2006 at 09:19:33AM +0200, sam@ravnborg.org wrote:
> > When we introduced -rR then aic7xxx no loger could pick up definition
> > of YACC&LEX from make - so do it explicit now.
> 
> > --- a/drivers/scsi/aic7xxx/aicasm/Makefile
> > +++ b/drivers/scsi/aic7xxx/aicasm/Makefile
> > @@ -14,6 +14,8 @@ LIBS=	-ldb
> >  clean-files:= ${GENSRCS} ${GENHDRS} $(YSRCS:.y=.output) $(PROG)
> >  # Override default kernel CFLAGS.  This is a userland app.
> >  AICASM_CFLAGS:= -I/usr/include -I.
> > +LEX= flex
> > +YACC= bison
> >  YFLAGS= -d
> >  
> >  NOMAN=	noman
> 
> SuSv3 lists "lex" and "yacc" as _the_ names. Is there any distro which
> doesn't install compat symlinks?
Other places in kernel hardcode bison/flex so to be consistent aic7xxx
does the same.

	Sam
