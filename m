Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbUCTXMx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 18:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263570AbUCTXMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 18:12:53 -0500
Received: from post1.dk ([62.242.36.44]:62226 "EHLO post1.dk")
	by vger.kernel.org with ESMTP id S263568AbUCTXMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 18:12:49 -0500
Content-Disposition: inline
Content-Transfer-Encoding: binary
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
Subject: Re: 2.6.4-mm2
From: sam@ravnborg.org
Reply-To: sam@ravnborg.org
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=iso-8859-1
X-Mailer: acmemail <URL:http://www.astray.com/acmemail/>
Message-Id: <20040320231248.89BBA15C1E@post1.dk>
Date: Sun, 21 Mar 2004 00:12:48 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Lør, 20 Mar 2004 23:50:30 +0100 skrev Olaf Hering <olh@suse.de> : 

>
>I think that one made it into rc2. It breaks uml compilation, 
>
>  CC	   kernel/acct.o
>  IKCFG   kernel/ikconfig.h
>  GZIP    kernel/config_data.gz
>  IKCFG   kernel/config_data.h
>/bin/sh: line 1: scripts/bin2c: No such file or directory
>make[1]: *** [kernel/config_data.h] Error 1
>make: *** [kernel] Error 2
>error: Bad exit status from /var/tmp/rpm-tmp.18419 (%build)
>
>looks like IKCFG does not depend on scripts/bin2c anymore?

There is a missing dependency on 'scripts' in the Makefile.
Try add scripts as target on the line that says something like:


$(SUBDIRS): prepare-all scripts
                        ^---- The scripts target you shall add.
     $(Q)$(MAKE) $(build)=$@


Cannot test rigth now - not on my Linux machine.

     Sam
