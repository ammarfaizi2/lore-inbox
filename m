Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266498AbUHBNlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUHBNlp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 09:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266523AbUHBNlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 09:41:45 -0400
Received: from witte.sonytel.be ([80.88.33.193]:10426 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266498AbUHBNlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 09:41:36 -0400
Date: Mon, 2 Aug 2004 15:41:17 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jens Axboe <axboe@suse.de>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: serialize access to ide device
In-Reply-To: <20040802131150.GR10496@suse.de>
Message-ID: <Pine.GSO.4.58.0408021540070.12449@waterleaf.sonytel.be>
References: <20040802131150.GR10496@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Aug 2004, Jens Axboe wrote:
> +		schedule_timeout(HZ/100);

Hmm, we still have a few platforms where HZ < 100.

Probably safer to use `schedule_timeout((HZ+99)/100);'?

BTW, did anyone ever audit the kernel for such usages?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
