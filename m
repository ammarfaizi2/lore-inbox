Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286454AbSAHLD7>; Tue, 8 Jan 2002 06:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286488AbSAHLDt>; Tue, 8 Jan 2002 06:03:49 -0500
Received: from mailgate.bodgit-n-scarper.com ([62.49.233.146]:8967 "HELO
	mould.bodgit-n-scarper.com") by vger.kernel.org with SMTP
	id <S286454AbSAHLDd>; Tue, 8 Jan 2002 06:03:33 -0500
Date: Tue, 8 Jan 2002 11:13:02 +0000
From: Matt Dainty <matt@bodgit-n-scarper.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
Message-ID: <20020108111302.A14860@mould.bodgit-n-scarper.com>
Mail-Followup-To: Richard Gooch <rgooch@ras.ucalgary.ca>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com> <200201061934.g06JYnZ15633@vindaloo.ras.ucalgary.ca> <3C38BC6B.7090301@zytor.com> <200201062108.g06L8lM17189@vindaloo.ras.ucalgary.ca> <3C38BD32.6000900@zytor.com> <200201070131.g071VrM20956@vindaloo.ras.ucalgary.ca> <3C38FAB0.4000503@zytor.com> <200201070140.g071ewk21192@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201070140.g071ewk21192@vindaloo.ras.ucalgary.ca>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 on i686 SMP (mould)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2002 at 06:40:58PM -0700, Richard Gooch wrote:
> 
> So I'd like to propose a new file (say kernel/smp.c) which has generic
> startup code for each CPU. To start with, it can have a
> generic_cpu_init() function, which is called by each arch. Note that
> this function would be called for the boot CPU too.

Would this also be hacked into whatever Hotswap CPU support exists? Such
that plugging in a new CPU spawns a new cpu/%d directory, (and removing one
deletes the directory), or do we just scan for the total number of possible
slots on boot and rely on any nodes to return -ENODEV or whatever when
there's no CPU physically present? (Probably easier)

(Maybe not smp.c, as this is for Uniprocessor boxen as well, cpu.c? :-)

Matt
-- 
"Phased plasma rifle in a forty-watt range?"
"Hey, just what you see, pal"
