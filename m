Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292020AbSBOAgo>; Thu, 14 Feb 2002 19:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292031AbSBOAgj>; Thu, 14 Feb 2002 19:36:39 -0500
Received: from [209.195.52.114] ([209.195.52.114]:18185 "HELO [209.195.52.30]")
	by vger.kernel.org with SMTP id <S292020AbSBOAg2>;
	Thu, 14 Feb 2002 19:36:28 -0500
From: David Lang <david.lang@digitalinsight.com>
To: ccroswhite@get2chip.com
Cc: linux-kernel@vger.kernel.org
Date: Thu, 14 Feb 2002 16:34:33 -0800 (PST)
Subject: Re: Problems with VM
In-Reply-To: <3C6C53C0.E7562704@get2chip.com>
Message-ID: <Pine.LNX.4.44.0202141630300.1985-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the linux kernel does not free any memory until someone needs it.

the way things should be happening is that the kernel will keep ~4-5M ram
free to be allocated instantly, and the rest of it will be used as cache.
Some percentage of the cache has been cleaned and is available to be
thrown out quickly if it is needed.

Some Swap space will be used in normal operation (when you start some
programs they use a huge amount of space and force things into swap, the
kernel will leave it there unless it is needed to run)

seeing swap space used is not cause for concern, only worry if you see
bunch of swap activity (lots of disk access) during your normal
operations.

David Lang




On Thu, 14 Feb 2002 ccroswhite@get2chip.com wrote:

> Date: Thu, 14 Feb 2002 16:18:08 -0800
> From: ccroswhite@get2chip.com
> To: linux-kernel@vger.kernel.org
> Subject: Problems with VM
>
> I am having difficulties with memory allocation in  teh 2.4.17 kernel.
> Memory is being agressively given as cache but not retrieved to be used
> as 'normal' ran.  Consequently, I will have a machine that has 5M
> 'normal' RAM, 800M 'cache' RAM and the reset coming out of swap space.
> I need this 'cache' RAM placed back into the available RAM pool to be
> used by applications.  Is there a patch/kernel configuration that I can
> change this behavior?
>
> Chris Croswhite
> Get2Chip, Inc.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
