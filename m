Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318729AbSG0KZ5>; Sat, 27 Jul 2002 06:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318730AbSG0KZ5>; Sat, 27 Jul 2002 06:25:57 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:1271 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S318729AbSG0KZ4>; Sat, 27 Jul 2002 06:25:56 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ivan Gyurdiev <ivangurdiev@attbi.com>
Reply-To: ivangurdiev@attbi.com
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5.29 - xconfig fails
Date: Fri, 26 Jul 2002 06:32:31 -0400
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200207260632.31691.ivangurdiev@attbi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[root@cobra linux-2.5]# make xconfig
make[1]: Entering directory `/usr/src/linux-2.5.29/scripts'
  gcc -Wp,-MD,./.fixdep.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer   
-o fixdep fixdep.c
  gcc -Wp,-MD,./.tkparse.o.d -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer  -c -o tkparse.o tkparse.c
  gcc -Wp,-MD,./.tkcond.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  
-c -o tkcond.o tkcond.c
  gcc -Wp,-MD,./.tkgen.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  
-c -o tkgen.o tkgen.c
  gcc  -o tkparse tkparse.o tkcond.o tkgen.o 
  Generating kconfig.tk
fs/partitions/Config.in: 28: can't handle dep_bool/dep_mbool/dep_tristate 
condition
chmod 755 kconfig.tk
make[1]: Leaving directory `/usr/src/linux-2.5.29/scripts'
wish -f scripts/kconfig.tk
Error in startup script: invalid command name "clear_choices"
    while executing
"clear_choices"
    (procedure "read_config" line 3)
    invoked from within
"read_config $defaults"
    invoked from within
"if { [file readable .config] == 1} then {
        if { $argc > 0 } then {
                if { [lindex $argv 0] != "-D" } then {
                        read_config .config
                }
                else
                {
                        r..."
    (file "scripts/kconfig.tk" line 646)
make: *** [xconfig] Error 1

