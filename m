Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317558AbSFIFHq>; Sun, 9 Jun 2002 01:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317559AbSFIFHp>; Sun, 9 Jun 2002 01:07:45 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:37899 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S317558AbSFIFHo>; Sun, 9 Jun 2002 01:07:44 -0400
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org, chaffee@cs.berkeley.edu
Subject: Re: [patch] fat/msdos/vfat crud removal
In-Reply-To: <200206090446.g594k8u492544@saturn.cs.uml.edu>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 09 Jun 2002 14:07:32 +0900
Message-ID: <87d6v1doq3.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

> OGAWA Hirofumi writes:
> > "Albert D. Cahalan" <acahalan@cs.uml.edu> writes:
> 
> >> - * Conversion from and to little-endian byte order. (no-op on i386/i486)
> >> - *
> >> - * Naming: Ca_b_c, where a: F = from, T = to, b: LE = little-endian,
> >> - * BE = big-endian, c: W = word (16 bits), L = longword (32 bits)
> >> - */
> >> -
> >> -#define CF_LE_W(v) le16_to_cpu(v)
> >> -#define CF_LE_L(v) le32_to_cpu(v)
> >> -#define CT_LE_W(v) cpu_to_le16(v)
> >> -#define CT_LE_L(v) cpu_to_le32(v)
> >
> > Personally I think this patch makes code readable. But please don't
> > remove Cx_LE_x macros. Cx_LE_x is used from dosfsck.
> 
> Then the macros should be put in dosfsck, which is not
> part of the kernel.

Why do we throw away backward compatible?

> > -	logical_sector_size =
> > -		le16_to_cpu(get_unaligned((unsigned short *) &b->sector_size));
> > +	logical_sector_size = le16_to_cpu(get_unaligned((u16*)&b->sector_size));
> 
> I notice lots of casts in the code. It would be better to
> use the correct types to begin with.

No, this field is aliment problem.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
