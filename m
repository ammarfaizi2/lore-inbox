Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264244AbRFKMFI>; Mon, 11 Jun 2001 08:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264435AbRFKME6>; Mon, 11 Jun 2001 08:04:58 -0400
Received: from druid.if.uj.edu.pl ([149.156.64.221]:21511 "HELO
	druid.if.uj.edu.pl") by vger.kernel.org with SMTP
	id <S264244AbRFKMEt>; Mon, 11 Jun 2001 08:04:49 -0400
Date: Mon, 11 Jun 2001 14:06:14 +0200 (CEST)
From: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>
To: Pavel Machek <pavel@suse.cz>
Cc: Bernd Jendrissek <berndj@prism.co.za>, <linux-kernel@vger.kernel.org>
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <20010608193224.A36@toy.ucw.cz>
Message-ID: <Pine.LNX.4.33.0106111401270.6622-100000@druid.if.uj.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jun 2001, Pavel Machek wrote:

> That modulo is likely slower than dereference.
>
> > +               if (count % 256 == 0) {

You are forgetting that this case should be converted to and 255 or a
plain byte reference by any optimizing compiler - and gcc surely is,
on x86 this code can be reduced to around 2 cycles (Pentium: mov, or, jnz,
with preceding code intertwined to cancel stalls and jnz being likely in
the code buffer)...

Maciek

