Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267428AbUHSViZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267428AbUHSViZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 17:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267433AbUHSViZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 17:38:25 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:9329 "EHLO
	smtp-out2.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S267428AbUHSViV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 17:38:21 -0400
Message-ID: <41251DCC.9070601@blueyonder.co.uk>
Date: Thu, 19 Aug 2004 22:38:20 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.8.1-mm2 make ?config fails
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Aug 2004 21:38:42.0791 (UTC) FILETIME=[E5F88F70:01C48634]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make xconfig/config/menuconfig/oldconfig - SuSE 9.1 Athlon 3000+. All is 
fine on x86_64 Athlon 3000+ laptop with SuSE 9.1 x86_64.
barrabas:/usr/src/linux-2.6.8.1-mm2 # make mrproper
  CLEAN   scripts/basic
  CLEAN   scripts/kconfig
  CLEAN   .config .config.old
barrabas:/usr/src/linux-2.6.8.1-mm2 # make xconfig
  HOSTCC  scripts/basic/fixdep
scripts/basic/fixdep.c: In function `do_config_file':
scripts/basic/fixdep.c:275: warning: implicit declaration of function 
`close'
  HOSTCC  scripts/basic/split-include
scripts/basic/split-include.c: In function `main':
scripts/basic/split-include.c:97: warning: implicit declaration of 
function `chdir'
  HOSTCC  scripts/basic/docproc
scripts/basic/docproc.c: In function `exec_kernel_doc':
scripts/basic/docproc.c:84: warning: implicit declaration of function `fork'
scripts/basic/docproc.c:89: warning: implicit declaration of function 
`execvp'
  SHIPPED scripts/kconfig/zconf.tab.h
  HOSTCC  scripts/kconfig/conf.o
scripts/kconfig/conf.c: In function `main':
scripts/kconfig/conf.c:498: warning: implicit declaration of function 
`isatty'
sed < scripts/kconfig/lkc_proto.h > scripts/kconfig/lkc_defs.h 
's/P(\([^,]*\),.*/#define \1 (\*\1_p)/'
  HOSTCC  scripts/kconfig/kconfig_load.o
  HOSTCC  scripts/kconfig/mconf.o
scripts/kconfig/mconf.c: In function `init_wsize':
scripts/kconfig/mconf.c:116: error: `STDIN_FILENO' undeclared (first use 
in this function)
scripts/kconfig/mconf.c:116: error: (Each undeclared identifier is 
reported only once
scripts/kconfig/mconf.c:116: error: for each function it appears in.)
scripts/kconfig/mconf.c: In function `exec_conf':
scripts/kconfig/mconf.c:223: warning: implicit declaration of function 
`pipe'
scripts/kconfig/mconf.c:224: warning: implicit declaration of function 
`fork'
scripts/kconfig/mconf.c:227: warning: implicit declaration of function 
`dup2'
scripts/kconfig/mconf.c:228: warning: implicit declaration of function 
`close'
scripts/kconfig/mconf.c:230: warning: implicit declaration of function 
`execv'
scripts/kconfig/mconf.c:231: warning: implicit declaration of function 
`_exit'
scripts/kconfig/mconf.c:238: warning: implicit declaration of function 
`read'
scripts/kconfig/mconf.c: In function `conf':
scripts/kconfig/mconf.c:441: warning: implicit declaration of function 
`unlink'
scripts/kconfig/mconf.c: In function `show_textbox':
scripts/kconfig/mconf.c:551: warning: implicit declaration of function 
`write'
make[1]: *** [scripts/kconfig/mconf.o] Error 1
make: *** [xconfig] Error 2

Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====

