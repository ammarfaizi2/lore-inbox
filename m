Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262497AbTCMTvJ>; Thu, 13 Mar 2003 14:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262508AbTCMTvI>; Thu, 13 Mar 2003 14:51:08 -0500
Received: from 66-23-198-138.clients.speedfactory.net ([66.23.198.138]:4871
	"EHLO www.outpostsentinel.com") by vger.kernel.org with ESMTP
	id <S262497AbTCMTvH>; Thu, 13 Mar 2003 14:51:07 -0500
Subject: exec terminating and all output not being seen
From: Christopher Fowler <cfowler@outpostsentinel.com>
To: linux-kernel@vger.kernel.org
Cc: cfowler@linuxiceberg.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Mar 2003 15:06:36 -0500
Message-Id: <1047585996.22029.25.camel@cfowler.outpostsentinel.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel Version: 2.4.18

On a serial console, I'm issues a command like 'exec ls'



Autologin
[root@cas8]# exec ls /
bin   dbin  dev 
[attached]



Autologin
[root@cas8]# 


I'm not getting all output before a new getty is spawned by init. Now
I'll execute 'exec strace ls /'

old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x402b1000
mprotect(0x401b2000, 733184, PROT_READ|PROT_WRITE) = 0
mprotect(0x401b2000, 733184, PROT_READ|PROT_EXEC) = 0
mprote
[attached]



Autologin
[root@cas8]# 

Again I get part of the strace but then it is cut off.  I do not have a
problem when streaming data, just when using exec. I am running my own
init with mgetty and my own login.  So maybe my tty is not setup
correctly.  Is there something I forgot to do?

Thanks,
Chris 





