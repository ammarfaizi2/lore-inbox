Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132865AbQL3RyJ>; Sat, 30 Dec 2000 12:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133087AbQL3RyA>; Sat, 30 Dec 2000 12:54:00 -0500
Received: from csa.iisc.ernet.in ([144.16.67.8]:57874 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S132865AbQL3Rxo>;
	Sat, 30 Dec 2000 12:53:44 -0500
Date: Sat, 30 Dec 2000 22:46:04 +0530 (IST)
From: Sourav Sen <sourav@csa.iisc.ernet.in>
Reply-To: Sourav Sen <sourav@csa.iisc.ernet.in>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Whats the problem
Message-ID: <Pine.SOL.3.96.1001230222916.20774B-100000@kohinoor.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am unable to compile the following code, can anyone say whats the
problem :

The main error msg is like the following:

	parse error before `EXPORT_SYMTAB_not_defined'
	warning: type defaults to `int' in declaration of
`EXPORT_SYMTAB_not_defined'
	warning: data definition has no type or storage class
 
==================================
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/sched.h>
#include <linux/unistd.h>
#include <linux/modversions.h>

int init_module()
{
	printk("Hello, World\n");
	return 0 ;
}

int show_mystate(void)
{
	unsigned long state ;
	state = current->state ;
	printk("%x\n",state);
	return 0 ;
}	

EXPORT_SYMBOL(show_mystate);

void cleanup_module()
{
	printk("Goodbye\n");
}

=============================================
 The makefile 

CC=gcc
MODCFLAGS=-Wall -DMODULE -D__KERNEL__ -DLINUX

showinfo.o : showinfo.c

		$(CC) $(MODCFLAGS) -c showinfo.c


Thanks
Sourav
--------------------------------------------------------------------------------
SOURAV SEN    MSc(Engg.) CSA IISc BANGALORE URL : www2.csa.iisc.ernet.in/~sourav 
ROOM NO : N-78      TEL :(080)309-2454(HOSTEL)          (080)309-2906 (COMP LAB) 
--------------------------------------------------------------------------------


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
