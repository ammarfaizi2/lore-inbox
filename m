Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934432AbWKXFuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934432AbWKXFuU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 00:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934433AbWKXFuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 00:50:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:34843 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S934432AbWKXFuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 00:50:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=X5OkFm9hROyLjPf9cxOdEwqLG65QyuXxYnBjSPEWTpmex4ExxVAMIOBu9yyXkr3pK5qfyRFAImt0urf4xWWMTve8oNuYK2fi4agXm+JLwuz51rnIHC8lJRHTRa/JclF8yQPFH00ncVOppCeOkXmZTvkakl4tKKFm7i5tr7gGDQM=
Message-ID: <db74e4d30611232150o36859417q78f688afa3709266@mail.gmail.com>
Date: Fri, 24 Nov 2006 11:20:17 +0530
From: atoka <atrockz@gmail.com>
To: kernelnewbies@nl.linux.org, lkml <linux-kernel@vger.kernel.org>
Subject: Kernel cross compilation error
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi everyone,
        im a kernel newbie. im using a debian linux(ie ubuntu).i did
cross compilation for ia64 on my system which is ia32. Now im trying
to cross compile ia64 kernel but im getting some error. before
compiling kernel, i did made changes in Makefile to specify my
ia64-linux compiler and libraries .

when i gave make menuconfig command i got following errors

root@atoka-desktop:/linux-2.6.18# make ARCH=ia64 menuconfig
  HOSTCC  scripts/basic/fixdep
scripts/basic/fixdep.c: In function 'use_config':
scripts/basic/fixdep.c:204: error: 'PATH_MAX' undeclared (first use in
this function)
scripts/basic/fixdep.c:204: error: (Each undeclared identifier is
reported only once
scripts/basic/fixdep.c:204: error: for each function it appears in.)
scripts/basic/fixdep.c:204: warning: unused variable 's'
scripts/basic/fixdep.c: In function 'parse_dep_file':
scripts/basic/fixdep.c:300: error: 'PATH_MAX' undeclared (first use in
this function)
scripts/basic/fixdep.c:300: warning: unused variable 's'
make[1]: *** [scripts/basic/fixdep] Error 1
make: *** [scripts_basic] Error 2

i tried defining the PATH_MAX macro in fixdep.c to 100, but then it
gave error in some other file.
Can anyone help me out with this error?
