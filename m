Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262896AbVFVIBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbVFVIBk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 04:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbVFVHwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:52:55 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:18705 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S262816AbVFVHqt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 03:46:49 -0400
Message-ID: <42B91764.1080208@slaphack.com>
Date: Wed, 22 Jun 2005 02:46:44 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Hans Reiser <reiser@namesys.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <20050620235458.5b437274.akpm@osdl.org> <42B831B4.9020603@pobox.com> <42B87318.80607@namesys.com> <20050621202448.GB30182@infradead.org> <42B8B9EE.7020002@namesys.com> <42B8BB5E.8090008@pobox.com> <42B8E834.5030809@slaphack.com> <20050622053656.GB28228@infradead.org>
In-Reply-To: <20050622053656.GB28228@infradead.org>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Christoph Hellwig wrote:
> On Tue, Jun 21, 2005 at 11:25:24PM -0500, David Masover wrote:
>
>>>You're basically implementing another VFS layer inside of reiser4, which
>>>is a big layering violation.
>>
>>There's been sloppy code in the kernel before.  I remember one bit in
>>particular which was commented "Fuck me gently with a chainsaw."  If I
>>remember correctly, this had all of the PCI ids and the names and
>>manufacturers of the corresponding devices -- in a data structure -- in
>>C source code.  It was something like one massive array definition, or
>>maybe it was a structure.  I don't remember exactly, but...
>
>
> Every device driver has a big array of corresponing device ids as an
> array in C code - oh my god we're doomed  .. not.

I could throw the same sarcasm back at you.  We must be doomed because
Reiser does some stuff that VFS already does!  Or am I misunderstanding
the complaint?

>>I agree there, too.  In fact, some people have suggested that all
>>"legacy" (read: non-reiser) filesystems should be implemented as Reiser4
>>plugins, effectively killing VFS.*
>>
>>So, Reiser4 may eventually take over VFS and be the only Linux
>>filesystem, but if so, it will have to do it much more slowly.  Take the
>>good ideas -- things like plugins -- and make them at least look like
>>incremental updates to the current VFS, and make them available to all
>>filesystems.
>
>
> And why exactly would we replace a stable, working abstraction with an
unpoven
> mess?

How does it get proven if you won't give it a chance as a *separate*
unproven mess, with a big fat EXPERIMENTAL flag, for users to play with?

I know, it exists as a separate patch.  But it works now, and I think
the best way to "prove" it would be to package it with the kernel.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQrkXY3gHNmZLgCUhAQLQUw//ZFN1KS+2wS/yDMa+/oWXVemZ690sMCLx
ZlKGg82bnv2XxqMXQwuPG9V02oN/D+1bkPmZzr8rD/tm5WshxpAHroIhnp3ZVpRi
lbMwULFQ8Z8fcsY3+YUag4XAUYGK+tmIeZc47FJGL0avsRa3RFJsFm+Kb6E/fi2f
H4wda43rt2CJYD5GqCtMsqyxzHzPclKHq25betIcPWBOqvE5NzQbc2tFTo0n3KMb
vmyZc4B34kiKhrrW/7pZCxDpiGjoxr87F19Tk8IIltM9kAuSVLXgtY/T+2DA2vJE
2N/Offr1rZh9zSq8PGkGoI+K41AaY3CkeYGjUF2eiZd4qwE624/1jUSEg685Puse
091EuIMzdndJYM0H+OsaFtvH9Rc67Hv6yR7aucNF5j8sIam37y7Fl+MToRgJK1+E
7YSpm/Ld61RaPqbJ4mqv4f0fHLTa2SpbFI8vmA1ARuiA+/YtUz9jBjLrPtMo4ppj
VvNTVMmftUgRr1NlQ+MKJO4Kxt4kKQnt1OtUe2y4bjCqO7ldUvPWLKGhsY0EsS0k
9yymlBbhsjTFrY9CsyrThshyHe9ikBVSLY7i16W+KhjLF/FKaq9k93nHd4B5Shni
Km9zyd0DlCUr3Y20SpBDITCWtM0CL0YQzeEW0JJTxVpHIDjh6s65XcBfrlWwEUiw
j/GJZA5h+bw=
=fBov
-----END PGP SIGNATURE-----
