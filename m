Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261429AbSJIAzL>; Tue, 8 Oct 2002 20:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSJIAyK>; Tue, 8 Oct 2002 20:54:10 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:22796 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S263228AbSJIAyA>; Tue, 8 Oct 2002 20:54:00 -0400
Date: Wed, 9 Oct 2002 01:59:31 +0100
From: John Levon <levon@movementarian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: tidy for the max_thread stuff from the kernel list
Message-ID: <20021009005931.GA86803@compsoc.man.ac.uk>
References: <E17yzhk-0004vR-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17yzhk-0004vR-00@the-village.bc.nu>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *17z5CG-000Lq2-00*wotdX9mBcaw* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 08:07:40PM +0100, Alan Cox wrote:

>  	/*
> -	 * we need to allow at least 10 threads to boot a system
> +	 * we need to allow at least 20 threads to boot a system
>  	 */
> -	init_task.rlim[RLIMIT_NPROC].rlim_cur = max(10, max_threads/2);
> -	init_task.rlim[RLIMIT_NPROC].rlim_max = max(10, max_threads/2);
> +	if(max_threads < 20)
> +		max_threads = 20;
> +
> +	init_task.rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
> +	init_task.rlim[RLIMIT_NPROC].rlim_max = max_threads/2;

Colour me dense, but the comment says 20, and you set rlim_max to 20/2.

Can this possibly be right ?

john
-- 
"I will eat a rubber tire to the music of The Flight of the Bumblebee"
