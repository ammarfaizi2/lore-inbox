Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267392AbSLSWIK>; Thu, 19 Dec 2002 17:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267173AbSLSWHS>; Thu, 19 Dec 2002 17:07:18 -0500
Received: from [195.39.17.254] ([195.39.17.254]:6148 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266537AbSLSWGc>;
	Thu, 19 Dec 2002 17:06:32 -0500
Date: Thu, 19 Dec 2002 00:45:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "H. Peter Anvin" <hpa@transmeta.com>, Ulrich Drepper <drepper@redhat.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021218234512.GA705@elf.ucw.cz>
References: <3DFFED33.2020201@transmeta.com> <Pine.LNX.4.44.0212172005500.1230-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212172005500.1230-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Btw, on another tangent - Andrew Morton reports that APM is unhappy about
> the fact that the fast system call stuff required us to move the segments
> around a bit. That's probably because the APM code has the old APM segment
> numbers hardcoded somewhere, but I don't see where (I certainly knew about
> the segment number issue, and tried to update the cases I saw).
> 
> Debugging help would be appreciated, especially from somebody who knows
> the APM code.

IIRC, segment 0x40 was special in BIOS days, and some APM bioses
blindly access 0x40 even from protected mode (windows have segment
0x40 with base 0x400....) Is that issue you are hitting?
								Pavel

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
