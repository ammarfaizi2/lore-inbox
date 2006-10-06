Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422686AbWJFOHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422686AbWJFOHm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 10:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422690AbWJFOHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 10:07:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:36619 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422686AbWJFOHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 10:07:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h3R8JuANDh5FDIaRy0WHrfMZ/FA4i+Mvy3wS/EQiukXkWlcqXAM7LcegLK5qISfJYWXyXxRLVEARSHtiOTk7jvzNXUM8/3ZAiPNjNUr5VFZ1UK9EJXJd8Vo8tC0vXiMyUf5QzQ1P0T2BI1mo10BbWqqoLW3o3FnS537Ls2E20x4=
Message-ID: <d120d5000610060707p13a9e97fkcb1219164da3f2d1@mail.gmail.com>
Date: Fri, 6 Oct 2006 10:07:39 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
Cc: "Jeff Garzik" <jeff@garzik.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "David Howells" <dhowells@redhat.com>, "Andrew Morton" <akpm@osdl.org>,
       "Thomas Gleixner" <tglx@linutronix.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       "Greg KH" <greg@kroah.com>, "David Brownell" <david-b@pacbell.net>,
       "Alan Stern" <stern@rowland.harvard.edu>
In-Reply-To: <20061006112550.GA21733@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061002132116.2663d7a3.akpm@osdl.org>
	 <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
	 <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>
	 <18975.1160058127@warthog.cambridge.redhat.com>
	 <4525A8D8.9050504@garzik.org>
	 <1160133932.1607.68.camel@localhost.localdomain>
	 <45263ABC.4050604@garzik.org> <20061006111156.GA19678@elte.hu>
	 <45263D9C.9030200@garzik.org> <20061006112550.GA21733@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Jeff Garzik <jeff@garzik.org> wrote:
>
> > >but pt_regs is alot less frequently used than irq - and where it's
> > >used they arent "drivers" but mostly arch level code like hw-timer
> > >handlers.
> >
> > Nonetheless the -vast majority- of drivers don't use the argument at
> > all, and the minority that do use it are not modern drivers.
>
> i'm all for changing that too :)
>

What drivers use irq argument? I know i8042 does but only to detect
whether interrupt routine was called because irq was raised or it was
called manually and I can use dev_id for that...

-- 
Dmitry
