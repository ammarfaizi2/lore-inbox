Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271594AbRHQVAB>; Fri, 17 Aug 2001 17:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271659AbRHQU7v>; Fri, 17 Aug 2001 16:59:51 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7040 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271594AbRHQU7r>;
	Fri, 17 Aug 2001 16:59:47 -0400
Date: Fri, 17 Aug 2001 13:57:06 -0700 (PDT)
Message-Id: <20010817.135706.74750097.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: aia21@cam.ac.uk, tpepper@vato.org, f5ibh@db0bm.ampr.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E15Xfev-0006zJ-00@the-village.bc.nu>
In-Reply-To: <no.id>
	<E15Xfev-0006zJ-00@the-village.bc.nu>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Fri, 17 Aug 2001 10:11:17 +0100 (BST)
   
   Its actually basically impossible to do back compat macros
   with this mess. Your original smin() umin() proposal was _much_ saner.

I don't see how you can logically say this.
My sint_min() etc. version broke things just
as equally because it had:

#define min __compile_error_do_not_use_min
#define max __compile_error_do_not_use_max

in it.  Do you think Linus or myself, by doing
this, intended to let anyone undef the damn things
to get around this?

The whole point of the changes was "min and max are
dumb, nobody may use them in their traditional form".

I was pretty sure, you understood this.

Later,
David S. Miller
davem@redhat.com
