Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129477AbQKMPnA>; Mon, 13 Nov 2000 10:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129469AbQKMPmu>; Mon, 13 Nov 2000 10:42:50 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:58353 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129465AbQKMPmo>;
	Mon, 13 Nov 2000 10:42:44 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3A1009DB.CC98CE06@mandrakesoft.com> 
In-Reply-To: <3A1009DB.CC98CE06@mandrakesoft.com>  <3A10031B.79D8A9B5@mandrakesoft.com> <3A0FF138.A510B45@mandrakesoft.com> <7572.974120930@redhat.com> <20554.974126251@redhat.com> <26373.974128444@redhat.com> 
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: torvalds@transmeta.com, dhinds@valinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 13 Nov 2000 15:42:34 +0000
Message-ID: <29549.974130154@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jgarzik@mandrakesoft.com said:
>  Thanks for all the explanation, I think I now understand all the
> stuff your kernel thread is doing.  Your solution sounds like a decent
> solution for the problem described.  I have not looked at the socket
> driver code observe parse_events() usage, so I cannot say whether your
> problem description is accurate however :)

It's the socket drivers which _aren't_ in the kernel source which are most
likely to exhibit this problem. Anything in the kernel tree was probably
converted by Linus, and hence done right. As there are so few socket drivers
in his tree, the amount of code duplication wasn't immediately obvious
either.

The offenders are the multitude of PCMCIA and CF socket drivers for 
embedded boards which are floating around. They aren't likely to get merged 
into 2.4, unfortunately - but I think we should at least make this 
available in order for them to work correctly.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
