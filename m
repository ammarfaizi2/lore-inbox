Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317561AbSFIGcl>; Sun, 9 Jun 2002 02:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317572AbSFIGck>; Sun, 9 Jun 2002 02:32:40 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:45836 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S317561AbSFIGcj>; Sun, 9 Jun 2002 02:32:39 -0400
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org, chaffee@cs.berkeley.edu
Subject: Re: [patch] fat/msdos/vfat crud removal
In-Reply-To: <200206090603.g5963FA458690@saturn.cs.uml.edu>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 09 Jun 2002 15:32:26 +0900
Message-ID: <87r8jhc685.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

> OGAWA Hirofumi writes:
> > "Albert D. Cahalan" <acahalan@cs.uml.edu> writes:
> >> OGAWA Hirofumi writes:
> >>> "Albert D. Cahalan" <acahalan@cs.uml.edu> writes:
> 
> >>>> - * Conversion from and to little-endian byte order. (no-op on i386/i486)
> >>>> - *
> >>>> - * Naming: Ca_b_c, where a: F = from, T = to, b: LE = little-endian,
> >>>> - * BE = big-endian, c: W = word (16 bits), L = longword (32 bits)
> >>>> - */
> >>>> -
> >>>> -#define CF_LE_W(v) le16_to_cpu(v)
> >>>> -#define CF_LE_L(v) le32_to_cpu(v)
> >>>> -#define CT_LE_W(v) cpu_to_le16(v)
> >>>> -#define CT_LE_L(v) cpu_to_le32(v)
> >>>
> >>> Personally I think this patch makes code readable. But please don't
> >>> remove Cx_LE_x macros. Cx_LE_x is used from dosfsck.
> >>
> >> Then the macros should be put in dosfsck, which is not
> >> part of the kernel.
> >
> > Why do we throw away backward compatible?
> 
> 1. app source code isn't supposed to use raw kernel headers
> 2. existing executables are not affected
> 3. the 2.5.xx series has already broken much more
> 4. it's crud for the kernel; it's crud for user code
> 5. the kernel shouldn't contain misc. user app code

Why is there __KERNEL__ macro?

> Use the packed attribute on the struct, along with
> the right types. I don't think you need get_unaligned
> with a packed struct, because gcc will know that it
> needs to emit code for unaligned data.

OK. Please send patch.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
