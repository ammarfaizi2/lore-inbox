Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266772AbSLJWQ2>; Tue, 10 Dec 2002 17:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266792AbSLJWQ2>; Tue, 10 Dec 2002 17:16:28 -0500
Received: from [66.70.28.20] ([66.70.28.20]:56068 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S266772AbSLJWQ0>; Tue, 10 Dec 2002 17:16:26 -0500
Date: Tue, 10 Dec 2002 23:25:53 +0100
From: DervishD <raul@pleyades.net>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Patch reversion needed too for -ac and 2.5.x
Message-ID: <20021210222553.GB46@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi David :)

    I understand why you suggested the reversion, and, unfortunately,
the MM code is plagued by bad usage of the PAGE_ALIGN macro. This
macro fails for aligning a *size* when this size is larger than
SIZE_MAX-PAGE_SIZE. Too bad.

    Anyway, if you want the patch reverted, tell too to Alan Cox and
Linus, because their branches have this patch applied and well,
although I think that the patch does no harm, really the solution is
to write a new macro for aligning sizes, not addresses, and this is a
very big change that surely won't be accepted.

    Tell Alan and Linus for having the patch reverted for their trees
if you feel like that. Do you think that a new macro will solve the
corner case without doing nothing on 'big TASK_SIZE' archs? If you
think so, I can provide with a macro and have it checked by you :)

    Don't take it bad, Dave ;) It's just that althoug my solution was
not perfect, certainly is best than what we have now ;)

    Raúl
