Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129458AbQKNCUm>; Mon, 13 Nov 2000 21:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129465AbQKNCUc>; Mon, 13 Nov 2000 21:20:32 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:35343 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S129458AbQKNCUV>; Mon, 13 Nov 2000 21:20:21 -0500
Date: Mon, 13 Nov 2000 17:50:17 -0800
From: Richard Henderson <rth@twiddle.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] show_task() and thread_saved_pc() fix for x86
Message-ID: <20001113175017.B1820@twiddle.net>
In-Reply-To: <Pine.LNX.4.10.10011111844080.3611-100000@penguin.transmeta.com> <Pine.GSO.4.21.0011112207230.24250-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.GSO.4.21.0011112207230.24250-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000 at 10:18:46PM -0500, Alexander Viro wrote:
> Alternative variant: just let schedule() store its return address
> in the task_struct.

Please please.  I can't reliably unwind the stack on Alpha.

> OTOH, the value is used only by Alt-SysRq-T, so... Hell knows.

No, it's also used by 'ps -l'.  See wchan.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
