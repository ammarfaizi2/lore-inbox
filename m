Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbVIVHtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbVIVHtH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbVIVHss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:48:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:211 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751440AbVIVHsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:48:41 -0400
Date: Thu, 22 Sep 2005 00:46:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: vgoyal@in.ibm.com
Cc: ebiederm@xmission.com, anderson@redhat.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] Kdump(x86): add note type NT_KDUMPINFO to
 kernel core dumps
Message-Id: <20050922004648.07a4147f.akpm@osdl.org>
In-Reply-To: <20050922073914.GA3753@in.ibm.com>
References: <20050921065633.GC3780@in.ibm.com>
	<m1mzm6ebqn.fsf@ebiederm.dsl.xmission.com>
	<20050922073914.GA3753@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> wrote:
>
> > - Why do you avoid storing the current task on the other cpus?
>  > 
>  > - Can't we derive the current task from the existing register information
>  >   already captured.  
> 
>  It can be done but as Dave suggested but that requires significant amount 
>  of job to be done as one has to traverse through the active task stacks and
>  look for crash_kexec(). An easier/simpler way is that kernel itself can 
>  report it.  Netdump, diskdump already do it. I think for simplicity, it 
>  makes sense to export this information from kernel in the form of note.
> 
>  Only issue I could think of is stack overflow and current might be 
>  corrupted after panic.
> 

Yes, traversing the task_structs in a crashed kernel sounds like a poor
idea.

