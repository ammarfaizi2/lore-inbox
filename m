Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbTLBPvX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 10:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTLBPvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 10:51:23 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:19693 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262195AbTLBPvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 10:51:21 -0500
From: Christian Borntraeger <kernel@borntraeger.net>
To: ajbezerra@ufam.edu.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.0] Resident memory info in fs/proc/task_mmu.c
Date: Tue, 2 Dec 2003 16:50:19 +0100
User-Agent: KMail/1.5.4
Cc: linux-mm@vger.kernel.org, riel@nl.linux.org
References: <18562.200.212.156.130.1070375149.squirrel@webmail.ufam.edu.br>
In-Reply-To: <18562.200.212.156.130.1070375149.squirrel@webmail.ufam.edu.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312021650.20036.kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ajbezerra@ufam.edu.br wrote:
> Hi everyone,
>
> Here is a suggestion for a patch of fs/proc/task_mm.c which gives
> more information about resident memory allocation for a given
> process PID at /proc/PID/status.
> -       unsigned long data = 0, stack = 0, exec = 0, lib = 0;
> -       struct vm_area_struct *vma;
> -
> -       down_read(&mm->mmap_sem);
> -       for (vma = mm->mmap; vma; vma = vma->vm_next) {
[...]
> +  unsigned long data = 0, stack = 0, exec = 0, lib = 0;
[...]
> +  struct vm_area_struct *vma;
> +  down_read(&mm->mmap_sem);
[...]

and so on.

Why are you breaking the Coding style? Can you keep the standard indentation 
please? This will make your patch much smaller and easier to see what you 
actually changed.

cheers

Christian

