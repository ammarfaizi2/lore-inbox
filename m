Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314811AbSD2GgE>; Mon, 29 Apr 2002 02:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314820AbSD2GgD>; Mon, 29 Apr 2002 02:36:03 -0400
Received: from paemt7015-180-188-079.dsl.telebrasilia.net.br ([200.180.188.79]:12548
	"HELO dyn162-188.crt.net.br") by vger.kernel.org with SMTP
	id <S314811AbSD2GgB>; Mon, 29 Apr 2002 02:36:01 -0400
Date: Sun, 28 Apr 2002 03:33:05 -0300
From: Uilton Dutra <uilton@uiltrix.com.br>
To: "Wanghong Yuan" <wyuan1@ews.uiuc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to enable printk
Message-Id: <20020428033305.7f501358.uilton@uiltrix.com.br>
In-Reply-To: <001001c1ef3d$890a6d50$e6f7ae80@ad.uiuc.edu>
Organization: Uiltrix Technology
X-Mailer: Sylpheed version 0.7.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In default priority printk maybe don't show anything on terminal, try printk("<1>yes\n"). Remenber that you can't use xterm. 

Uilton Dutra
uilton@uiltrix.com.br
http://iam.uiltrix.com.br

On Mon, 29 Apr 2002 00:20:11 -0500
"Wanghong Yuan" <wyuan1@ews.uiuc.edu> wrote:

//Hi,
//
//It may be a simple question. But I cannot see the result of printk in
//console like the following. Do i need to enable it somewhere? Thanks
//
///*-O2 -Wall -DMODULE -D__KERNEL__ -DLINUX -c testsys.c */
//
//#include <linux/sys.h>
//#include <linux/mm.h>
//#include <linux/module.h>
//#include <linux/kernel.h>
//#include <linux/sched.h>
//#include <sys/syscall.h>
//#include <asm/uaccess.h>
//
//
///* The system call number we attempt to install ourselves as. */
//static int syscall_num = 165;
//
//asmlinkage int sys_test(int pid, int period, int cycles, int* ptr)
//
//{
//
// put_user(current->pid, ptr);
// return pid-10000;
//
//}
//
//extern int sys_call_table[];
//
//#ifdef MODULE
//int init_module(void)
//{
//  printk("yes\n");
//  sys_call_table[syscall_num] = (int)sys_test;
//  return 0;
//}
//
//void cleanup_module(void)
//{
//  sys_call_table[syscall_num] = 0;
//}
//
//#endif /* MODULE */
//
//
//-
//To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
//the body of a message to majordomo@vger.kernel.org
//More majordomo info at  http://vger.kernel.org/majordomo-info.html
//Please read the FAQ at  http://www.tux.org/lkml/
//
