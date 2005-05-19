Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262463AbVESMMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbVESMMG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 08:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVESMMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 08:12:05 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:61601 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262463AbVESMMB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 08:12:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nvvbbMCKL1vxb9yGFI+7aGowKaWhK+NtZmbtP9Q2HKxlI4CgLlD61znMIPzQ2ZC/45Li3Im1haMNxnWK0Ka6kx78marnbfvO/YE1X/SqpCW5zJN+htYZfyt3XzxE/UxfVCEVRel0iVKDqnGgVATwMDXt93OPah9/R7GwxR6zVm4=
Message-ID: <377362e1050519051228ae3e72@mail.gmail.com>
Date: Thu, 19 May 2005 21:12:01 +0900
From: "Tetsuji \"Maverick\" Rai" <tetsuji.rai@gmail.com>
Reply-To: "Tetsuji \"Maverick\" Rai" <tetsuji.rai@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: HT scheduler: is it really correct? or is it feature of HT?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200505192123.24784.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <377362e10505181142252ec930@mail.gmail.com>
	 <377362e105051902467cae323e@mail.gmail.com>
	 <377362e105051903462a4d8949@mail.gmail.com>
	 <200505192123.24784.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for nice hints!!  I'm trying with several values, and found
actually as you said, it affects the nice=0 process.

On 5/19/05, Con Kolivas <kernel@kolivas.org> wrote:
> Your code does not do what you think it is doing either. If you want to change
> the bias between nice levels across logical cores search the code for where
> the value of sd->per_cpu_gain is set. It is currently set to 25% and you want
> to increase it (although as I said you will derive no real world benefit as
> your nice 0 task will just slow down).
> 
> Cheers,
> Con
> 


-- 
Luckiest in the world / Weapon of Mass Distraction
http://maverick6664.bravehost.com/
Aviation Jokes: http://www.geocities.com/tetsuji_rai/
Background: http://maverick.ns1.name/
