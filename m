Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284794AbSAPR2R>; Wed, 16 Jan 2002 12:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284902AbSAPR1k>; Wed, 16 Jan 2002 12:27:40 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:9344
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S285093AbSAPR1Q>; Wed, 16 Jan 2002 12:27:16 -0500
Date: Wed, 16 Jan 2002 12:10:58 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, Lukas Geyer <geyer@ml.kva.se>
Subject: Re: Two issues with 2.4.18pre3 on PPC
Message-ID: <20020116121058.B5940@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, Lukas Geyer <geyer@ml.kva.se>
In-Reply-To: <Pine.LNX.4.33.0201161417540.6868-100000@cauchy.ml.kva.se> <20020116163737.29030@mailhost.mipsys.com> <20020116170554.GA771@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020116170554.GA771@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Wed, Jan 16, 2002 at 10:05:54AM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org>:
> Eric, do you think you could modify the CONFIG_RTC help entry to mention
> that on PPC you should use the CONFIG_PPC_RTC option and not CONFIG_RTC,
> if in doubt?  That's probably the best fix for 2.4.x

Done.

However, the *right* fix is

derive PPC_RTC from RTC & ((S390==n and APUS==n) or (APUS!=n and CONFIG_4xx))

eliminating PPC_RTC as a separate question entirely and hiding a platform 
detail.  
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

To make inexpensive guns impossible to get is to say that you're
putting a money test on getting a gun.  It's racism in its worst form.
        -- Roy Innis, president of the Congress of Racial Equality (CORE), 1988
