Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265608AbTBTPnn>; Thu, 20 Feb 2003 10:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265612AbTBTPnn>; Thu, 20 Feb 2003 10:43:43 -0500
Received: from mail.actcom.co.il ([192.114.47.13]:55470 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S265608AbTBTPnm>; Thu, 20 Feb 2003 10:43:42 -0500
Date: Thu, 20 Feb 2003 17:49:52 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Burton Windle <bwindle-kbt@fint.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix bug 376 - tiny extra echo in Makefile
Message-ID: <20030220154952.GB1202@actcom.co.il>
References: <20030220124948.GC17614@actcom.co.il> <Pine.LNX.4.44.0302200935590.19487-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302200935590.19487-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 09:38:58AM -0600, Kai Germaschewski wrote:
> On Thu, 20 Feb 2003, Muli Ben-Yehuda wrote:
> 
> > --- a/Makefile	Thu Feb 20 13:40:59 2003
> > +++ b/Makefile	Thu Feb 20 13:40:59 2003
> > @@ -325,7 +325,7 @@
> >  define rule_vmlinux__
> >  	set -e
> >  	$(if $(filter .tmp_kallsyms%,$^),,
> > -	  echo '  Generating build number'
> > +	  @echo '  Generating build number'
> >  	  . $(src)/scripts/mkversion > .tmp_version
> >  	  mv -f .tmp_version .version
> >  	  $(Q)$(MAKE) $(build)=init
> 
> The thing is, I cannot reproduce it here.
> 
> Also, the entire rule_vmlinux__ is invoked with a '@' in front, so nothing
> there should be echoed. However, for the original submitter that obviously
> doesn't work, the ". $(src)..." line is echoed to. What version of "make"
> is used?

Burton, which make version are you using? on which distro? 

FWIW, I can't reproduce it here on RH 7.3 with make 3.79.1. Trying on
debian unstable now.
-- 
Muli Ben-Yehuda
http://www.mulix.org

