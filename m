Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270140AbTGPGak (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 02:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270158AbTGPGak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 02:30:40 -0400
Received: from web20006.mail.yahoo.com ([216.136.225.69]:53259 "HELO
	web20006.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270140AbTGPGai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 02:30:38 -0400
Message-ID: <20030716064528.59509.qmail@web20006.mail.yahoo.com>
Date: Tue, 15 Jul 2003 23:45:28 -0700 (PDT)
From: navneet panda <navneet_panda@yahoo.com>
Subject: kernel 2.6.0-test-acl   make modules errors
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

I wished to bring to ur attention the following
problems I experienced while trying to install the new
kernel.

I downloaded the entire source for 2.6 and then
applied the patch 2.6.0-test1-ac1

Initially I just tried with my old config file from
kernel 2.4.20 and accepting all the defaults. The
problem faced was in the file riscom8.c and the output
was
***********************************

  CC [M]  drivers/char/riscom8.o
In file included from drivers/char/riscom8.c:51:
drivers/char/riscom8.h:84: field `tqueue' has
incomplete type
drivers/char/riscom8.h:85: field `tqueue_hangup' has
incomplete type
drivers/char/riscom8.c:84: warning: type defaults to
`int' in declaration of `DECLARE_TASK_QUEUE'
drivers/char/riscom8.c:84: warning: parameter names
(without types) in function
declaration
drivers/char/riscom8.c:135: confused by earlier
errors, bailing out
make[2]: *** [drivers/char/riscom8.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

***************************************

After changing the config file the following was
encountered. In the file drivers/net/defxx.c in line
202 the line 

#error Please convert me to
Documentation/DMA-mapping.tx

needed to be commented out

The last error encountered was in the file 
drivers/net/fc/iph5226.c

 CC [M]  drivers/net/fc/iph5526.o
In file included from drivers/net/fc/iph5526.c:66:
drivers/net/fc/iph5526_scsi.h:28: parse error before
'*' token
drivers/net/fc/iph5526_scsi.h:28: warning: function
declaration isn't a prototype
drivers/net/fc/iph5526.c: In function `iph5526_open':
drivers/net/fc/iph5526.c:2900: warning:
`MOD_INC_USE_COUNT' is deprecated (declared at
include/linux/module.h:481)
drivers/net/fc/iph5526.c: In function `iph5526_close':
drivers/net/fc/iph5526.c:2907: warning:
`MOD_DEC_USE_COUNT' is deprecated (declared at
include/linux/module.h:493)
drivers/net/fc/iph5526.c: In function `add_to_sest':
drivers/net/fc/iph5526.c:4230: structure has no member
named `address'
drivers/net/fc/iph5526.c:4330: structure has no member
named `address'
drivers/net/fc/iph5526.c:4339: structure has no member
named `address'
drivers/net/fc/iph5526.c:4345: structure has no member
named `address'
drivers/net/fc/iph5526.c: In function `iph5526_init':
drivers/net/fc/iph5526.c:4485: warning: implicit
declaration of function `scsi_register_host'
drivers/net/fc/iph5526.c:4491: warning: implicit
declaration of function `scsi_unregister_host'
drivers/net/fc/iph5526.c: At top level:
drivers/net/fc/iph5526.c:4474: warning: `io' defined
but not used
drivers/net/fc/iph5526.c:4475: warning: `irq' defined
but not used
drivers/net/fc/iph5526.c:4476: warning: `bad' defined
but not used
make[3]: *** [drivers/net/fc/iph5526.o] Error 1
make[2]: *** [drivers/net/fc] Error 2
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

I couldn't get over this error. This is my first post
to the list and I am sorry if I have made any
mistakes. I just wanted to help.

Thanks
Panda







__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
