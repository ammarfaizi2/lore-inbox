Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317424AbSFXGwR>; Mon, 24 Jun 2002 02:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317426AbSFXGwQ>; Mon, 24 Jun 2002 02:52:16 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:60178 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id <S317424AbSFXGwQ>; Mon, 24 Jun 2002 02:52:16 -0400
Date: Mon, 24 Jun 2002 08:53:06 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
To: Marc Lefranc <lefranc.m@free.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: aha152x driver broken in 2.4.19-pre10
In-Reply-To: <p6rznxlhkcy.fsf@free.fr>
Message-ID: <Pine.LNX.4.21.0206240847410.442-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jun 2002, Marc Lefranc wrote:

> it looks like the aha152x driver was broken between 2.4.19-pre8 and
> 2.4.19-pre10. Apparently there is a problem with a lost interrupt. I
> am afraid I cannot do much to fix this problem, but I am willing to
> perform any test that would help.

Hi,

same for me. AFAICS when looking into the diff which got into -pre10 the
only change around the place where the lost interrupt is detected is a
dropped spin_lock_irq() around a 1sec mdelay() while probing the
interrupt. The interesting observation however is with 2.5.24 which has
exactly the same code as 2.4.19-pre10 and - surprise - does work for me
just fine. So I don't have a good idea what might cause the problem with
2.4.19-pre10...

Martin

