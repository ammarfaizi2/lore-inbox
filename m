Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265249AbTLFVDF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 16:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbTLFVDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 16:03:05 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:9737 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S265249AbTLFVDC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 16:03:02 -0500
To: Michal Rokos <m.rokos@sh.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.0-test11] VFAT fix for UTF-8 and trailing dots
References: <20031206085539.GA3134@nightmare.sh.cvut.cz>
	<87d6b2vt94.fsf@devron.myhome.or.jp>
	<20031206192919.GA31981@nightmare.sh.cvut.cz>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 07 Dec 2003 06:02:47 +0900
In-Reply-To: <20031206192919.GA31981@nightmare.sh.cvut.cz>
Message-ID: <87iskt8xs8.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Rokos <m.rokos@sh.cvut.cz> writes:

> I don't know... Functions in nls_base.c have specification the same as
> those from userspace (defined by ISO/ANSI C or UNIX98).
> 
> Probably we should. This was meant as minimal patch.
> 
> In case you'll be modifiing nls_base.c, please, decide whether this
> shouldn't be in...
> 
> 
> --- linux-2.6.0-test11/fs/nls/nls_base.c.old	2003-11-26 21:44:31.000000000 +0100
> +++ linux-2.6.0-test11/fs/nls/nls_base.c	2003-12-06 20:09:01.000000000 +0100
> @@ -99,6 +99,7 @@ utf8_mbstowcs(wchar_t *pwcs, const __u8 
>  			}
>  		} else {
>  			*op++ = *ip++;
> +			n--;
>  		}
>  	}
>  	return (op - pwcs);
> > 
> > For example, utf8_mbstowcs(outbuf, outlen, inbuf, inlen);
> > 
> 
> I'd would propose uft8_mbsntowcs(outbuf, outlen, inbuf, inlen);

Whoops, sorry. You are right.

But I really like the interface like iconv() than this. And current
nls interfaces also...

Anyway, I think your patches fix some bugs right now.
I'll submit the your both patches.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
