Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316459AbSE3IFI>; Thu, 30 May 2002 04:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316463AbSE3IFH>; Thu, 30 May 2002 04:05:07 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:50439 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316459AbSE3IFH>; Thu, 30 May 2002 04:05:07 -0400
Date: Thu, 30 May 2002 10:04:03 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: missing bit from signal patches
In-Reply-To: <20020530101848.2ac84805.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.21.0205300959050.17583-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 30 May 2002, Stephen Rothwell wrote:

> The following should allow the affected architectures to build in
> 2.5.19 as currently there will be two definitions of
> copy_siginfo_to_user.

There are other build problems. m68k doesn't compile, because siginfo_t is
defined after the generic include and the inline functions in there access
that structure. On the other hand I can't put the include after the
definition, as it depends on other defines in the include.
I worked around it with some ugly hacks, but a proper fix would be very
welcome.

bye, Roman

