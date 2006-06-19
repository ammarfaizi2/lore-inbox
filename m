Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWFSM0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWFSM0w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWFSMZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:25:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15806 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932425AbWFSMZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:25:24 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 15/15] frv: clean frv unistd.h
Date: Mon, 19 Jun 2006 13:25:16 +0100
To: torvalds@osdl.org, akpm@osdl.org, viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060619122516.10060.71734.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
References: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Remove _syscall invocations that aren't used in the kernel.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/asm-frv/unistd.h |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/include/asm-frv/unistd.h b/include/asm-frv/unistd.h
index dec80c1..af0f5dd 100644
--- a/include/asm-frv/unistd.h
+++ b/include/asm-frv/unistd.h
@@ -458,24 +458,7 @@ #include <asm/ptrace.h>
  * some others too.
  */
 #define __NR__exit __NR_exit
-static inline _syscall0(int,pause)
-static inline _syscall0(int,sync)
-static inline _syscall0(pid_t,setsid)
-static inline _syscall3(int,write,int,fd,const char *,buf,off_t,count)
-static inline _syscall3(int,read,int,fd,char *,buf,off_t,count)
-static inline _syscall3(off_t,lseek,int,fd,off_t,offset,int,count)
-static inline _syscall1(int,dup,int,fd)
 static inline _syscall3(int,execve,const char *,file,char **,argv,char **,envp)
-static inline _syscall3(int,open,const char *,file,int,flag,int,mode)
-static inline _syscall1(int,close,int,fd)
-static inline _syscall1(int,_exit,int,exitcode)
-static inline _syscall3(pid_t,waitpid,pid_t,pid,int *,wait_stat,int,options)
-static inline _syscall1(int,delete_module,const char *,name)
-
-static inline pid_t wait(int * wait_stat)
-{
-	return waitpid(-1,wait_stat,0);
-}
 
 #endif
 

