Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129283AbQKUS1S>; Tue, 21 Nov 2000 13:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129692AbQKUS1I>; Tue, 21 Nov 2000 13:27:08 -0500
Received: from nat-su-33.valinux.com ([198.186.202.33]:36216 "EHLO
	phenoxide.engr.valinux.com") by vger.kernel.org with ESMTP
	id <S129283AbQKUS07>; Tue, 21 Nov 2000 13:26:59 -0500
Date: Tue, 21 Nov 2000 09:56:26 -0800
From: Johannes Erdfelt <jerdfelt@valinux.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Oleg Drokin <green@ixcelerator.com>, linux-kernel@vger.kernel.org
Subject: Re: hardcoded HZ in hub.c
Message-ID: <20001121095626.F3431@valinux.com>
In-Reply-To: <20001120121746.F895@valinux.com> <20001117125441.A28208@iXcelerator.com> <20001120121746.F895@valinux.com> <1891.974801599@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <1891.974801599@redhat.com>; from dwmw2@infradead.org on Tue, Nov 21, 2000 at 10:13:19AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2000, David Woodhouse <dwmw2@infradead.org> wrote:
> 
> jerdfelt@valinux.com said:
> >  We applied a slightly different patch which is would not remove the
> > pages out from under the thread, using semaphores instead.
> 
> > This patch isn't needed anymore. Thanks anyway.
> 
> Actually, the best fix is probably to get rid of the thread entirely and use
> schedule_task to run usb_hub_events() instead.

That that possible? usb_hub_events can block for a long time. That is why
the kernel thread was needed. I'm not familiar with schedule_task enough
to know if it can be used.

JE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
