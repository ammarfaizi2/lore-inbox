Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312980AbSDGG7K>; Sun, 7 Apr 2002 01:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312986AbSDGG7K>; Sun, 7 Apr 2002 01:59:10 -0500
Received: from web20802.mail.yahoo.com ([216.136.226.191]:15877 "HELO
	web20802.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S312980AbSDGG7J>; Sun, 7 Apr 2002 01:59:09 -0500
Message-ID: <20020407065908.98437.qmail@web20802.mail.yahoo.com>
Date: Sat, 6 Apr 2002 22:59:08 -0800 (PST)
From: George Kola <procproj@yahoo.com>
Subject: /proc enhancement
To: linux-kernel@vger.kernel.org
In-Reply-To: <200203310133.SAA12760@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  We are working on a project to enhance linux /proc.
This is of particular importance to the 'Paradayn'
project (cs.wisc.edu/paradyn). 
  We want to add the ability to specifically trace a
set of system calls and the ability to trace  the
system call entry or exit or both. For this we wanted
to add two structs to

struct task_struct in include/linux/sched.h


struct  syscall_set {
   char traced[8];
}


we want to add 

struct syscall_set entry,exit; to task_struct in 
include/linux/sched.h

In the beginning of task_struct we found that

struct task_struct {
	/*
	 * offsets of these are hardcoded elsewhere - touch
with care
	 */

          We want to know what we would be breaking if
we add the structs at the end ? (so that we can fix
them)


         Also how do we initialize it in 
#define INIT_TASK(tsk) (we want to set all bits in the
struct to 1).


Thanks,
George

__________________________________________________
Do You Yahoo!?
Yahoo! Tax Center - online filing with TurboTax
http://taxes.yahoo.com/
