Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285417AbSAPRl4>; Wed, 16 Jan 2002 12:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285369AbSAPRlq>; Wed, 16 Jan 2002 12:41:46 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:18048
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S285060AbSAPRlm>; Wed, 16 Jan 2002 12:41:42 -0500
Date: Wed, 16 Jan 2002 12:25:25 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, Lukas Geyer <geyer@ml.kva.se>
Subject: Re: Two issues with 2.4.18pre3 on PPC
Message-ID: <20020116122525.A6712@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, Lukas Geyer <geyer@ml.kva.se>
In-Reply-To: <Pine.LNX.4.33.0201161417540.6868-100000@cauchy.ml.kva.se> <20020116163737.29030@mailhost.mipsys.com> <20020116170554.GA771@cpe-24-221-152-185.az.sprintbbd.net> <20020116121058.B5940@thyrsus.com> <20020116173116.GC771@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020116173116.GC771@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Wed, Jan 16, 2002 at 10:31:16AM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org>:
> Unless the user wants to use drivers/char/rtc.c because they're on a
> chrp or prep box.

OK, so the derivation right side should change a little (I'll take a patch).

The actual point is one of design philosophy.  Instead of presenting the 
ser with unnecessarily platform-specific questions, we should be asking
platform-independent (wherever this is possible) questions about the 
*capabilities* he/she wants and mixing that wuith information about the
platform.

I'll go further than that.  PP_RTC should probably never have existed
as a user-visible symbol and question in the first place, as it
duplicates what PPC is asking.  The derivation should actually take
place somewhere in the C code of the PPC port tree.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Rapists just *love* unarmed women.  And the politicians who disarm them.
