Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314682AbSEFTl5>; Mon, 6 May 2002 15:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314870AbSEFTl4>; Mon, 6 May 2002 15:41:56 -0400
Received: from ns.suse.de ([213.95.15.193]:25611 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314682AbSEFTlz>;
	Mon, 6 May 2002 15:41:55 -0400
Date: Mon, 6 May 2002 21:41:55 +0200
From: Dave Jones <davej@suse.de>
To: Peter Denison <lkml@marshadder.uklinux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/depca.c tidyup
Message-ID: <20020506214154.G22215@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Peter Denison <lkml@marshadder.uklinux.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020506193247.C22215@suse.de> <Pine.LNX.4.44.0205061944460.30139-100000@marshall.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2002 at 08:01:01PM +0100, Peter Denison wrote:

 > -	offset = (offset + ALIGN) & ~ALIGN;
 > +	offset = ALIGN(offset, 8);
 > 
 > And from include/linux/cache.h:
 > 
 > #define ALIGN(x,a) (((x)+(a)-1)&~((a)-1))
 > 
 > So, we're replacing (offset + 8 - 1) & ~(8-1) = (offset + 7) & ~7
 > with (((offset)+(8)-1)&~((8)-1)) = ((offset+7)&~7)

Argh, I was looking at the definition in linkage.h
Cursed ctags.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
