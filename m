Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbSJUMji>; Mon, 21 Oct 2002 08:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261369AbSJUMji>; Mon, 21 Oct 2002 08:39:38 -0400
Received: from 62-190-203-194.pdu.pipex.net ([62.190.203.194]:8714 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261368AbSJUMjh>; Mon, 21 Oct 2002 08:39:37 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210211255.g9LCt9aq004245@darkstar.example.net>
Subject: xconfig broken in 2.5.44?
To: linux-kernel@vger.kernel.org
Date: Mon, 21 Oct 2002 13:55:09 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe I'm missing something obvious, but:

make xconfig
make -f scripts/Makefile scripts/kconfig.tk
  gcc -Wp,-MD,scripts/.fixdep.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer   -o scripts/fixdep scripts/fixdep.c
  gcc -Wp,-MD,scripts/.tkparse.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -c -o scripts/tkparse.o scripts/tkparse.c
  gcc -Wp,-MD,scripts/.tkcond.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -c -o scripts/tkcond.o scripts/tkcond.c
  gcc -Wp,-MD,scripts/.tkgen.o.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -c -o scripts/tkgen.o scripts/tkgen.c
  gcc  -o scripts/tkparse scripts/tkparse.o scripts/tkcond.o scripts/tkgen.o 
  Generating scripts/kconfig.tk
drivers/pnp/Config.in: 7: can't handle dep_bool/dep_mbool/dep_tristate condition
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
