Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312983AbSDYIYA>; Thu, 25 Apr 2002 04:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312988AbSDYIX7>; Thu, 25 Apr 2002 04:23:59 -0400
Received: from www.webvilag.com ([193.194.159.23]:4107 "EHLO www.webvilag.com")
	by vger.kernel.org with ESMTP id <S312983AbSDYIX7>;
	Thu, 25 Apr 2002 04:23:59 -0400
Date: Thu, 25 Apr 2002 10:32:25 +0200
From: Szekeres Istvan <szekeres@webvilag.com>
To: linux-kernel@vger.kernel.org
Subject: Assembly question
Message-ID: <20020425083225.GA30247@webvilag.com>
Mail-Followup-To: Szekeres Istvan <szekeres@webvilag.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Long time ago (older gcc) this code snippet used to compile. Now it doesn't.
Do you asm gurus have any idea what is wrong?

void p_memset_dword( void *d, int b, int l )
{
    __asm__ ("rep\n\t"
             "stosl\n\t"
             :
             : "D" (d), "a" (b), "c" (l)
             : "memory","edi", "eax", "ecx"
            );
}

The compiler says:
a.c: In function `p_memset_dword':
a.c:9: Invalid `asm' statement:
a.c:9: fixed or forbidden register 0 (ax) was spilled for class AREG.

Thanks,
Pista

