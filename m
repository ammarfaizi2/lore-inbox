Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266135AbTBTRQL>; Thu, 20 Feb 2003 12:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266186AbTBTRPi>; Thu, 20 Feb 2003 12:15:38 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:17936 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266135AbTBTRP1>;
	Thu, 20 Feb 2003 12:15:27 -0500
Date: Thu, 20 Feb 2003 18:25:20 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Muli Ben-Yehuda <mulix@mulix.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix bug 376 - tiny extra echo in Makefile
Message-ID: <20030220172520.GB978@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Muli Ben-Yehuda <mulix@mulix.org>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030220124948.GC17614@actcom.co.il> <Pine.LNX.4.44.0302200935590.19487-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302200935590.19487-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 09:38:58AM -0600, Kai Germaschewski wrote:
> > diff -Nru a/Makefile b/Makefile
> > --- a/Makefile	Thu Feb 20 13:40:59 2003
> > +++ b/Makefile	Thu Feb 20 13:40:59 2003
> > @@ -325,7 +325,7 @@
> >  define rule_vmlinux__
> >  	set -e
> >  	$(if $(filter .tmp_kallsyms%,$^),,

While on the rule_vmlinux__ subject someone claimed that "set -e" does
not make sense because it will be invoked in its private copy of the shell.
Should the whole rule not be escaped "\", so it is executed in
one go by make?
Thats how other users of "set -e" works.

	Sam
