Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316089AbSEZWK5>; Sun, 26 May 2002 18:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316092AbSEZWK4>; Sun, 26 May 2002 18:10:56 -0400
Received: from ns.suse.de ([213.95.15.193]:57617 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316089AbSEZWK4>;
	Sun, 26 May 2002 18:10:56 -0400
Date: Mon, 27 May 2002 00:10:56 +0200
From: Dave Jones <davej@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.4] [2.5] [i386] Add support for GCC 3.1
Message-ID: <20020527001056.O16102@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>, rwhron@earthlink.net,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020526160217.A1343@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2002 at 04:02:17PM -0400, rwhron@earthlink.net wrote:

 > athlon-xp == athlon-4 == athlon-mp

Not quite...

>From gcc/config/i386/i386.c ..

   if (!ix86_arch_string)
                   ix86_arch_string = TARGET_64BIT ? "athlon-4" : "i386";

Discussion with Jan Hubicka reveals that this should be checking for
"opteron", but as this was the closest match, it's not equivalent
to athlon-xp or athlon-mp in current gcc.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
