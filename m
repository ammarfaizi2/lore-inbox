Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277380AbRJVAy0>; Sun, 21 Oct 2001 20:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277382AbRJVAyQ>; Sun, 21 Oct 2001 20:54:16 -0400
Received: from ns.suse.de ([213.95.15.193]:58894 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S277380AbRJVAyE>;
	Sun, 21 Oct 2001 20:54:04 -0400
Date: Mon, 22 Oct 2001 02:54:38 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Alan Cox <laughing@shared-source.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.12-ac5
In-Reply-To: <3BD36631.41618DE8@delusion.de>
Message-ID: <Pine.LNX.4.30.0110220249230.17514-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001, Udo A. Steinberg wrote:

> acpitable.c: In function `__va_range':
> acpitable.c:479: `FIX_IO_APIC_BASE_0' undeclared (first use in this function)
> acpitable.c:479: (Each undeclared identifier is reported only once
> acpitable.c:479: for each function it appears in.)
> acpitable.c:496: `FIX_IO_APIC_BASE_END' undeclared (first use in this function)

Odd, that part builds fine here. The missing declaration you get is
declared in fixmap.h, which is included from pgalloc.h. Untar a fresh tree,
and reapply the patch.

regards

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

