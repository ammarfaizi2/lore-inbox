Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313041AbSDYKZP>; Thu, 25 Apr 2002 06:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313054AbSDYKZO>; Thu, 25 Apr 2002 06:25:14 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:63500 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S313041AbSDYKZN>; Thu, 25 Apr 2002 06:25:13 -0400
Date: Thu, 25 Apr 2002 12:25:09 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Karim Yaghmour <karim@opersys.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Linux Trace Toolkit 0.9.5
In-Reply-To: <3CC72CDC.CF80C0C6@opersys.com>
Message-ID: <Pine.LNX.4.21.0204251154510.31280-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 24 Apr 2002, Karim Yaghmour wrote:

> As I said earlier, a 2.5.x patch is available and LTT is ready to
> be integrated into the 2.5 series.

I'd really like to see it go in, but I think some small problems are left,
mostly formatting. Please read Documentation/CodingStyle.
Please use tabs for indentation and not spaces.
You should consider using more inline functions, instead of lots of "do
{...} while(0)" macros.
Do we really need more usages of uint32_t or uint8_t in the kernel?
Instead of using lots of "#ifdef __arch__" you should move this into
<asm/trace.h>.
Comments are nice, but IMO your code does a bit too much of it, e.g.:

  /* Everything is OK */
  return 0;

or

  /* Unlock the table for reading */
  read_unlock(&custom_list_lock);

bye, Roman

