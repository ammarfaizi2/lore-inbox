Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130017AbQLRSfl>; Mon, 18 Dec 2000 13:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130325AbQLRSfb>; Mon, 18 Dec 2000 13:35:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:23813 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130017AbQLRSfX>;
	Mon, 18 Dec 2000 13:35:23 -0500
Date: Mon, 18 Dec 2000 19:04:42 +0100
From: Jens Axboe <axboe@suse.de>
To: Stelian Pop <stelian.pop@alcove.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Driver for emulating a tape device on top of a cd writer...
Message-ID: <20001218190442.B473@suse.de>
In-Reply-To: <20001218112529.B6315@wiliam.alcove-int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001218112529.B6315@wiliam.alcove-int>; from stelian.pop@alcove.fr on Mon, Dec 18, 2000 at 11:25:29AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18 2000, Stelian Pop wrote:
> Hi folks,
> 
> I've got this idea some time ago, thinking it would really be
> a neat thing...
> 
> Basically, I would like to be able to use a cdwriter as a tape
> device, with software like dump(8) or tar(1). With /dev/tcdw
> as name (for example), I'd like to be able to do:
>         mt -f /dev/tcdw rewind
>         tar cvf /dev/tcdw /
>         tar cvf /dev/tcdw /home
>         mt -f /dev/tcdw rewind
>         mt -f /dev/tcdw fsf 1
>         tar xvf /dev/tcdw
>         ...
> 
> As someone said to me, this seems to exist on some other UNIX
> system (don't recall if it was AIX or something else)... But
> I didn't find any work on Linux in this direction. 

What you describe is actually one of the goals of the packet writing
driver. To do this reliably you need packet writing, I won't even
start to think about the headaches wihtout it...

> I'll start to work on this, probably by looking at the cdrecord 
> low level code and porting it into kernel space.

Oh god no! You can do all this from user space.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
