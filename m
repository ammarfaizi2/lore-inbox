Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290072AbSAKT47>; Fri, 11 Jan 2002 14:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290077AbSAKT4t>; Fri, 11 Jan 2002 14:56:49 -0500
Received: from zero.tech9.net ([209.61.188.187]:15 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290072AbSAKT4l>;
	Fri, 11 Jan 2002 14:56:41 -0500
Subject: Re: [PATCH] Small optimization for UP in sched and prefetch
From: Robert Love <rml@tech9.net>
To: Rainer Keller <Keller@hlrs.de>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <3C3EBF76.3AEB82AB@hlrs.de>
In-Reply-To: <3C3EBF76.3AEB82AB@hlrs.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 11 Jan 2002 14:59:20 -0500
Message-Id: <1010779162.2139.3.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-01-11 at 05:33, Rainer Keller wrote:

> -/* Prefetch instructions for Pentium III and AMD Athlon */
> -#ifdef 	CONFIG_MPENTIUMIII
> +/* Prefetch instructions for Pentium III, Pentium 4 and AMD Athlon */
> +#if defined(CONFIG_MPENTIUMIII) || defined(CONFIG_MPENTIUM4)

if we really intend to check for the use of the AMD Athlon as well, we
need to add CONFIG_MK7, too.  Since the Athlon does have this prefetch,
it would make sense.  Otherwise, the comment is wrong.

Anyhow, good patch and I can't see it not being safe for 2.4.

	Robert Love

