Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280883AbRKLSGT>; Mon, 12 Nov 2001 13:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280902AbRKLSGJ>; Mon, 12 Nov 2001 13:06:09 -0500
Received: from [195.63.194.11] ([195.63.194.11]:47880 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S280883AbRKLSF7>; Mon, 12 Nov 2001 13:05:59 -0500
Message-ID: <3BF01BEB.788C1BEC@evision-ventures.com>
Date: Mon, 12 Nov 2001 19:58:51 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Mark Peloquin <peloquin@us.ibm.com>
CC: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
Subject: Re: Hardsector size support in 2.4 and 2.5
In-Reply-To: <OF052859B1.127521A3-ON85256B02.00602D84@raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Peloquin wrote:
> 
> I was wondering if 2.5 will *really* support different hard sector
> sizes. Today the hardsect array in the kernel seems to serve
> little purpose. Drivers fill it in, but then what? It does not appear
> to be used in any io path computations as illustrated by code
> in submit_bh and generic_make_request which use a few
> hardcoded shifts by 9 when dealing with sector sizes.
> 
> Is the hardsect array on the way *in* or the way *out* of the
> kernel? Will 2.5 take the real hardsector value into account?
> Or can we expect everything to be handled in 512 byte
> multiples  (as we do today)?

It is on it's way out, since:

1. Most hardware sec sizes are obscelny lower that the minimal logical
sizes those days (512 ver. 4096 page size),
so the tuning there doesn't matter.

2. All of it is "tuning", which can be handled generically on higher
levels. (Like setting FS blocksize....)

3. The hard limits are handled on device driver level anyway (best
example here are the odd fs block sizes for iso9660 filesystem).
