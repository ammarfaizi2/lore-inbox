Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278582AbRJ1Q6N>; Sun, 28 Oct 2001 11:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278584AbRJ1Q6D>; Sun, 28 Oct 2001 11:58:03 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:50585
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S278582AbRJ1Q5q>; Sun, 28 Oct 2001 11:57:46 -0500
Date: Sun, 28 Oct 2001 09:58:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alexander Schulz <alex@shark-linux.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] RTC policy questions
Message-ID: <20011028095819.I15768@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <3BDC331E.50B8DB5E@shark-linux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BDC331E.50B8DB5E@shark-linux.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2001 at 05:32:30PM +0100, Alexander Schulz wrote:

> I am currently working on porting the linux kernel to
> the Shark, a StrongARM based computer (DNARD from digital)
> that contains many parts known from PCs.
[snip]
3) Re-write/replace drivers/char/rtc.c in 2.5.  This is something I've
been thinking about for a bit because of the number of 'generic' RTC
drivers, and how they only vary slighlty.  And then there are some
hw-specific RTC drivers (efirtc.c) which could be modified to be a
personality for the new generic rtc driver.  The m68k/APUS version right
now uses a 'mach_hwclk' which handles the actual get/set bits.  I
haven't worked out all of the details just yet, but I'm thinking some of
the arch/hw-specific bits will be in a different file and on a per-arch
baises on how mach_hwclk is actually done.  Eg PPC would still end up
calling the right ppc_md version, x86 (and default) would yeild the
current behavior.

And this all relates to the original post since we could make sure that
other arches have access to any functions they might need internally.

Is there anyone else out there who's been thinking about reworking the
RTC driver?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
