Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278383AbRJMTxL>; Sat, 13 Oct 2001 15:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278388AbRJMTxC>; Sat, 13 Oct 2001 15:53:02 -0400
Received: from ns.suse.de ([213.95.15.193]:16656 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S278386AbRJMTwr>;
	Sat, 13 Oct 2001 15:52:47 -0400
Date: Sat, 13 Oct 2001 21:53:19 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: <Jose_Jorge@teklynx.fr>, <linux-kernel@vger.kernel.org>
Subject: Re: kapmidled and AMD K6-2
In-Reply-To: <20011012130138.A35@toy.ucw.cz>
Message-ID: <Pine.LNX.4.30.0110132149210.32671-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2001, Pavel Machek wrote:

> If I don't want to build powertweak, are you willing to hack something up
> for me? ;-). [My k6-2 is too hot to slow down CPU fan. I tried throttling
> it using ACPI, but no success. I want to cool it down so that fan slows
> and machine becomes quiet.]

Certainly :-)
http://www.codemonkey.org.uk/cruft/ewbe.c is a quick and dirty hack.

You'll need the msr driver loaded, and the /dev node there.
I've not tested this code as my K6-2 box is currently in bits, but
it should be ok. Bits 2 & 3 in 0xc0000080 do the magic, so theres not
much that could be wrong.. If all else fails, double check the spec.

Let me know if this does anything for you at all
(regarding both temperature, and performance)

Oh, and for everyone else, as the comment in the source says,
don't run this on anything that isn't a K6-2 / K6-3.
I was too lazy to add cpuid checking to this. Maybe I'll do that
later..

regards,

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

