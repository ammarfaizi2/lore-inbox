Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131521AbRC0Txa>; Tue, 27 Mar 2001 14:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131524AbRC0TxV>; Tue, 27 Mar 2001 14:53:21 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:2052 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131521AbRC0TxF>;
	Tue, 27 Mar 2001 14:53:05 -0500
Message-ID: <20010327172354.A160@bug.ucw.cz>
Date: Tue, 27 Mar 2001 17:23:54 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jonathan Morton <chromi@cyberspace.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc: douglas@fang.demon.co.uk
Subject: Re: [PATCH] non-overcommit memory, improved OOM handling, safety margin (was Re: Prevent OOM from killing init)
In-Reply-To: <3ABE0F32.5255DF30@evision-ventures.com> <E14gVQf-00056B-00@the-village.bc.nu> <4.3.2.7.2.20010325123201.00be27d0@mail.fluent-access.com> <l03130326b6e4150a1de0@[192.168.239.101]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <l03130326b6e4150a1de0@[192.168.239.101]>; from Jonathan Morton on Sun, Mar 25, 2001 at 10:51:09PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The attached patch is against 2.4.1 and incorporates the following:

The patch seems to be word-wrapped...	
								Pavel

> diff -ur -x via-rhine* linux-2.4.1.orig/fs/exec.c linux/fs/exec.c
> ---
> linux-2.4.1.orig/fs/exec.c	Tue Jan 30 07:10:58 2001
> +++
> linux/fs/exec.c	Sun Mar 25 17:05:03 2001
> @@ -385,19 +385,27 @@
>  static int
> exec_mmap(void)
>  {
>  	struct mm_struct * mm, * old_mm;
> +	struct
> task_struct * tsk = current;
> +	unsigned long reserved = 0;
>  
> -	old_mm =
> current->mm;

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
