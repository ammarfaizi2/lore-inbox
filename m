Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWIZXlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWIZXlA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 19:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWIZXlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 19:41:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54202 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932443AbWIZXk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 19:40:59 -0400
Date: Tue, 26 Sep 2006 16:40:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Haavard Skinnemoen" <hskinnemoen@gmail.com>
Cc: "David Woodhouse" <dwmw2@infradead.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       =?ISO-8859-1?Q? "H=E5vard?= Skinnemoen" <hskinnemoen@atmel.com>
Subject: Re: [PATCH] avr32 architecture
Message-Id: <20060926164042.203e3089.akpm@osdl.org>
In-Reply-To: <1defaf580609261417v4d3ea0f3pb10699d60ad0323f@mail.gmail.com>
References: <200609261601.k8QG1Txd005700@hera.kernel.org>
	<1159304576.3309.54.camel@pmac.infradead.org>
	<1defaf580609261417v4d3ea0f3pb10699d60ad0323f@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2006 23:17:29 +0200
"Haavard Skinnemoen" <hskinnemoen@gmail.com> wrote:

> On 9/26/06, David Woodhouse <dwmw2@infradead.org> wrote:
> > On Tue, 2006-09-26 at 16:01 +0000, Linux Kernel Mailing List wrote:
> > > [PATCH] avr32 architecture
> >
> > pmac /pmac/git/linux-2.6 $ make ARCH=avr32 headers_check
> >   CHK     include/linux/version.h
> > make[1]: `scripts/unifdef' is up to date.
> >   CHECK   include/asm/user.h
> >   CHECK   include/asm/unistd.h
> > /pmac/git/linux-2.6/usr/include/asm/unistd.h requires linux/linkage.h, which does not exist in exported headers
> 
> Right. avr32-implement-kernel_execve.patch, which was flagged as "Will
> merge" by Andrew, fixes it by moving the #ifdef __KERNEL__ guard to
> cover everything but the __NR_foo definitions.

Ho hum, such leakage happens sometimes.

> So as long as that
> one's still scheduled for inclusion, I think sending a separate patch
> to fix this problem will do more harm than good.
> 

Yes, I'm planning on merging the execve cleanups for 2.6.19.  It's probably
a week away yet.
