Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129153AbQKXBSy>; Thu, 23 Nov 2000 20:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129255AbQKXBSo>; Thu, 23 Nov 2000 20:18:44 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:14160 "EHLO
        penguin.e-mind.com") by vger.kernel.org with ESMTP
        id <S129153AbQKXBS1>; Thu, 23 Nov 2000 20:18:27 -0500
Date: Fri, 24 Nov 2000 01:48:30 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kernel_thread bogosity
Message-ID: <20001124014830.I1461@athlon.random>
In-Reply-To: <20001123232333.A6426@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001123232333.A6426@bug.ucw.cz>; from pavel@suse.cz on Thu, Nov 23, 2000 at 11:23:33PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 11:23:33PM +0100, Pavel Machek wrote:
> Hi!
> 
> You see? Kernel_thread does not check is sys_clone() worked! Aha,

"=&a" (retval)

> caller is responsible for that, but init/main.c does not seem too
> carefull. Maybe kernel_thread should at least print a warning?

If clone fails during start_kernel that's the last of your problems so nobody
cared. If you want to add a check on the retval go ahead, that's right indeed.

> Plus, can someone explain me why it does not need to setup %%ecx with
> either zero or address of stack?

Not necessary because a kernel thread never exit from kernel.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
