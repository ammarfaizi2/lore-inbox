Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261913AbSIYEyT>; Wed, 25 Sep 2002 00:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbSIYEyS>; Wed, 25 Sep 2002 00:54:18 -0400
Received: from rains.umail.ucsb.edu ([128.111.151.216]:34833 "EHLO
	rains.umail.ucsb.edu") by vger.kernel.org with ESMTP
	id <S261913AbSIYEyS>; Wed, 25 Sep 2002 00:54:18 -0400
Message-ID: <1032929970.3d9142b22bc55@webaccess.umail.ucsb.edu>
Date: Tue, 24 Sep 2002 21:59:30 -0700
From: Lingli Zhang <lingli_z@umail.ucsb.edu>
To: linux-kernel@vger.kernel.org
Subject: mmap() failed on Linux 2.4.18-10smp with 4GB RAM
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1.1-cvs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

My machine is a 2-Processor Pentium 4 (Xeon) 2.4GHz e7500 Chipset with 4GB RAM.
I installed Redhat (kernel: Linux 2.4.18-10bigmem) on it. 

But when I run following piece of code:
========================================
#include <unistd.h>
#include <sys/mman.h>
int main(){
   mmap ((void *) 1090519040, 17000000,
         PROT_READ | PROT_WRITE | PROT_EXEC,
         MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
}
===========================================
It gives out "segmentation fault". It works well if I change 17000000
to 16000000.

I have tried Linux 2.4.18-10smp kernel, same problem.

Is there anyone have any idea what's going on here? Or do you have any
recommendation that which version of Linux I should use for my machine to work
around this problem?

Thanks a lot!

Lingli
-- 
Lingli Zhang
lingli_z@umail.ucsb.edu
