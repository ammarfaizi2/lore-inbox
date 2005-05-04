Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVEDS35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVEDS35 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 14:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVEDS3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 14:29:03 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:5513 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261352AbVEDS2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 14:28:25 -0400
Message-ID: <4279142A.8050501@ammasso.com>
Date: Wed, 04 May 2005 13:27:54 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Libor Michalek <libor@topspin.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs
 implementation
References: <200544159.Ahk9l0puXy39U6u6@topspin.com> <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com> <20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com> <20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com> <20050411171347.7e05859f.akpm@osdl.org> <20050412180447.E6958@topspin.com> <20050425203110.A9729@topspin.com>
In-Reply-To: <20050425203110.A9729@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Libor Michalek wrote:

>   The program opens the charcter device file descriptor, pins the pages
> and waits for a signal, before checking the pages, which is sent to the
> process after running some other program which exercises the VM. On older
> kernels the check fails, on my 2.6.11 kernel the check succeeds. So
> mlock is not needed on top of get_user_pages() as it was before.

Libor,

When you say "older", what exactly do you mean?  I have different test that normally fails 
with just get_user_pages(), but it works with 2.6.9 and above.  I haven't been able to get 
any kernel earlier than 2.6.9 to compile or boot properly, so I'm having a hard time 
narrowing down the actual point when get_user_pages() started working.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
