Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275368AbTHGO5L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275362AbTHGO4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:56:53 -0400
Received: from relay.comdominio.com.br ([200.142.211.2]:11986 "EHLO
	relay.comdominio.com.br") by vger.kernel.org with ESMTP
	id S275343AbTHGO4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:56:17 -0400
Message-ID: <000d01c37550$04b65ec0$6edea7c8@bsb.virtua.com.br>
From: "Breno" <breno@secforum.com.br>
To: "Kernel List" <linux-kernel@vger.kernel.org>
Subject: Problem getting all vmas
Date: Sun, 7 Sep 2003 11:55:01 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi , i tryed to get all vmas with this piece of code :


....
struct task_struct *task = find_task_by_pid();
struct vm_area_struct *vma,*next;

vma = task->mm->mmap;

while(vma)
{
     next = vma->vm_next;
    my_function();
    ....
    vma = next;
 }

but when i do insmod procm.o ... the program seems to enter in an infinite
loop.
Am I getting all vmas with this while() ?

thanks
Breno

