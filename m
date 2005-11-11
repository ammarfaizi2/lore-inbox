Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbVKKXBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbVKKXBd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 18:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVKKXBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 18:01:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9923 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751308AbVKKXBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 18:01:32 -0500
Date: Fri, 11 Nov 2005 15:01:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Antonino A. Daplas" <adaplas@pol.net>
Subject: Re: 2.6.14-mm2
Message-Id: <20051111150108.265b2d3f.akpm@osdl.org>
In-Reply-To: <6bffcb0e0511111432m771dcda2y@mail.gmail.com>
References: <20051110203544.027e992c.akpm@osdl.org>
	<6bffcb0e0511111432m771dcda2y@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>
> Hi,
> 
> On 11/11/05, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm2/
> >
> 
> Something is broken with nvidia framebuffer. When I try to login on
> tty1 "Password: " doesn't appear. It appear when I switch Alt+F2 to
> tty2 and then back to tty1.
> 

Yup, thanks.  Yesterday Ben reported:

> not 100% sure what's up, but current -git has funny breakage with
> nvidiafb on an iMac G5 I have here. The mode seems correct but the
> console uses one line too much of text.
> 
> That is, the total height of the screen isn't a multiple of the height
> of a line of text. It seems that fbcon is rounding up instead of down,
> thus the "last" line is basically going offscreen (about 2 or 3 pixels
> visible, the rest is offscreen).
> 

Which looks sort-of similar.

And Tony replied:

> What does stty -a say, and fbset -i?
