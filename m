Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285093AbSAPRc4>; Wed, 16 Jan 2002 12:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285022AbSAPRcv>; Wed, 16 Jan 2002 12:32:51 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:41600
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S285060AbSAPRbd>; Wed, 16 Jan 2002 12:31:33 -0500
Date: Wed, 16 Jan 2002 10:31:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, Lukas Geyer <geyer@ml.kva.se>
Subject: Re: Two issues with 2.4.18pre3 on PPC
Message-ID: <20020116173116.GC771@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <Pine.LNX.4.33.0201161417540.6868-100000@cauchy.ml.kva.se> <20020116163737.29030@mailhost.mipsys.com> <20020116170554.GA771@cpe-24-221-152-185.az.sprintbbd.net> <20020116121058.B5940@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020116121058.B5940@thyrsus.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 12:10:58PM -0500, Eric S. Raymond wrote:
> Tom Rini <trini@kernel.crashing.org>:
> > Eric, do you think you could modify the CONFIG_RTC help entry to mention
> > that on PPC you should use the CONFIG_PPC_RTC option and not CONFIG_RTC,
> > if in doubt?  That's probably the best fix for 2.4.x
> 
> Done.
> 
> However, the *right* fix is
> 
> derive PPC_RTC from RTC & ((S390==n and APUS==n) or (APUS!=n and CONFIG_4xx))

Unless the user wants to use drivers/char/rtc.c because they're on a
chrp or prep box.

The right fix is to make everyone use the m68k tree's actually generic
rtc driver in 2.5 :)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
