Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285120AbRLQNBa>; Mon, 17 Dec 2001 08:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285127AbRLQNBU>; Mon, 17 Dec 2001 08:01:20 -0500
Received: from ns.ithnet.com ([217.64.64.10]:20490 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S285120AbRLQNBP>;
	Mon, 17 Dec 2001 08:01:15 -0500
Date: Mon, 17 Dec 2001 14:00:36 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Yoshiki Hayashi <yoshiki@xemacs.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] 2.4.16 Fix NULL pointer dereferencing in agpgart_be.c
Message-Id: <20011217140036.4a0e8969.skraw@ithnet.com>
In-Reply-To: <87zo4iroxw.fsf@u.sanpo.t.u-tokyo.ac.jp>
In-Reply-To: <87zo4iroxw.fsf@u.sanpo.t.u-tokyo.ac.jp>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Dec 2001 21:50:03 +0900
Yoshiki Hayashi <yoshiki@xemacs.org> wrote:

> This patch is against 2.4.16.  I couldn't find maintainer in
> MAINTAINERS file so I'm simply sending this to Linus and
> linux-kernel list.
> 
> In apggart_be.c, if the chip is i830M and the secondary device is not
> found, linux kernel tries to dereference NULL pointer.  It checks NULL
> and returns from the function in the next statement but it's too late.
> 
> The attached patch add NULL check before dereferencing the
> pointer to fix the problem.

This was solved some weeks ago and the patch is pending somewhere (marcelo?).
Unfortunately the complete cure is inside this pending patch, because there are
other small tweaks for i830M. The NULL-check is sufficient for non-oops, but
i830-register size is smaller than the further ongoings inside agpgart_be.c.

Regards,
Stephan


