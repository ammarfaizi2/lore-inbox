Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbUL3FfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbUL3FfP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 00:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbUL3FfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 00:35:15 -0500
Received: from lakermmtao01.cox.net ([68.230.240.38]:25749 "EHLO
	lakermmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261543AbUL3FfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 00:35:08 -0500
In-Reply-To: <200412291347.JEH41956.OOtStPFFNMLJVGMYS@i-love.sakura.ne.jp>
References: <200412291347.JEH41956.OOtStPFFNMLJVGMYS@i-love.sakura.ne.jp>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9033584D-5A24-11D9-989E-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Is CAP_SYS_ADMIN checked by every program !?
Date: Thu, 30 Dec 2004 00:35:06 -0500
To: Tetsuo Handa <from-linux-kernel@i-love.sakura.ne.jp>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 28, 2004, at 23:47, Tetsuo Handa wrote:
> It seems to me that every program calls capable(CAP_SYS_ADMIN),

Umm, the program has nothing to do with this.  Programs themselves have 
no
access to the kernel function "capable".  Probably something in the 
kernel, perhaps
triggered by libc or maybe just suid checks, is checking for 
CAP_SYS_ADMIN. It's
harmless and irrelevant, why do you care?

> +       if (cap == CAP_SYS_ADMIN) {
> +               static pid_t last_pid = 0;
> +               if (current->pid != last_pid) {
> +                       printk("euid=%d uid=%d %s %s\n", 
> current->euid, current->uid, cap_raised(current->cap_effective, 
> CAP_SYS_ADMIN) ? "true" : "fa
> lse", current->comm);
> +                       last_pid = current->pid;
> +               }
> +       }

Yes, whenever anything on the computer, including the kernel, checks if 
a program
has a capability bit set, it will print out whether or not it does in 
the dmesg.  Why
does that matter?

> I can't understand why every program checks for CAP_SYS_ADMIN .
Programs aren't, the kernel is, for whatever reason.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


