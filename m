Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263658AbUDFL7O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 07:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263791AbUDFL7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 07:59:14 -0400
Received: from host24.tni.fr ([195.25.255.24]:58376 "HELO ender.tni.fr")
	by vger.kernel.org with SMTP id S263658AbUDFL7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 07:59:11 -0400
Subject: Re: {put,get}_user() side effects
From: Xavier Bestel <xavier.bestel@free.fr>
To: Andi Kleen <ak@muc.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <m3fzbhfijh.fsf@averell.firstfloor.org>
References: <1HVGV-1Wl-21@gated-at.bofh.it>
	 <m3fzbhfijh.fsf@averell.firstfloor.org>
Content-Type: text/plain
Message-Id: <1081252228.8318.1.camel@speedy.priv.grenoble.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.6 
Date: Tue, 06 Apr 2004 13:50:29 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-06 at 13:32 +0200, Andi Kleen wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> 
> > On most (all?) architectures {get,put}_user() has side effects:
> >
> > #define put_user(x,ptr)                                                 \
> >   __put_user_check((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))
> 
> Neither typeof not sizeof are supposed to have side effects. If your
> compiler generates them that's a compiler bug.

Using ptr three times in a define has side effects if ptr is an
expression with side effects (e.g. "p++").

	Xav

