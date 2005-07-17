Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVGQRzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVGQRzE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 13:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVGQRzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 13:55:04 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:46916 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261291AbVGQRzB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 13:55:01 -0400
Date: Sun, 17 Jul 2005 19:19:31 +0000
From: Sam Ravnborg <sam@ravnborg.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, blaisorblade@yahoo.it,
       jdike@addtoit.com
Subject: Re: UML build broken on 2.6.13-rc3-mm1
Message-ID: <20050717191931.GA8114@mars.ravnborg.org>
References: <E1Du4JM-0004dH-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Du4JM-0004dH-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2005 at 10:15:44AM +0200, Miklos Szeredi wrote:
> I get the following build failure on 2.6.13-rc3-mm1.  It builds fine
> on 2.6.13-rc3.
> 
> Can anybody help fixing it?
> 
> Thanks,
> Miklos
>   
> /usr/src/quilt/linux$ make ARCH=um V=1
> if test ! /usr/src/quilt/linux -ef /usr/src/quilt/linux; then \
> /bin/sh /usr/src/quilt/linux/scripts/mkmakefile              \
>     /usr/src/quilt/linux /usr/src/quilt/linux 2 6         \
>     > /usr/src/quilt/linux/Makefile;                                 \
>     echo '  GEN    /usr/src/quilt/linux/Makefile';                   \
> fi
>   CHK     include/linux/version.h
> rm -rf .tmp_versions
> mkdir -p .tmp_versions
> make -f scripts/Makefile.build obj=scripts/basic
> make -f scripts/Makefile.build obj= /mk_sc
> scripts/Makefile.build:13: /Makefile: No such file or directory
> scripts/Makefile.build:64: kbuild: Makefile.build is included improperly
> make[1]: *** No rule to make target `/Makefile'.  Stop.
> make: *** [/mk_sc] Error 2

Olaf just posted a patch fixing this problem. SYS_UTIL_DIRS is brought
back to fix it.

	Sam
