Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281263AbRKLFsd>; Mon, 12 Nov 2001 00:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281264AbRKLFsX>; Mon, 12 Nov 2001 00:48:23 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:2608 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S281263AbRKLFsT>; Mon, 12 Nov 2001 00:48:19 -0500
Date: Mon, 12 Nov 2001 00:47:19 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: [PATCH] save sound mixer state over suspend
Message-ID: <20011112004719.A6091@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.33.0111112107530.1518-100000@vaio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111112107530.1518-100000@vaio>; from kai@tp1.ruhr-uni-bochum.de on Sun, Nov 11, 2001 at 09:42:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Sun, 11 Nov 2001 21:42:27 +0100 (CET)
> From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
> To: <linux-kernel@vger.kernel.org>
> cc: Linus Torvalds <torvalds@transmeta.com>, Pete Zaitcev <zaitcev@redhat.com>

> The appended patch introduces two new functions to the ac97_codec 
> handling: ac97_save_state() and ac97_restore_state().
> These functions save/restore the mixer state over suspend. (So after 
> resume the volume is the same it was before)

The patch itself looks ok, but I am wondering what is
the difference between your ac97_restore_state and ac97_reset.
I think you may be reinventing the wheel here.

I cannot test the patch because my suspend/resume cycle
retains mixer levels without it (2.2.14 stock, PCG-Z505JE),
so I would not see any difference.

-- Pete
