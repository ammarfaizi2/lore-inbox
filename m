Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276489AbRJKPAu>; Thu, 11 Oct 2001 11:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276457AbRJKPAl>; Thu, 11 Oct 2001 11:00:41 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:3245 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S276453AbRJKPAd>; Thu, 11 Oct 2001 11:00:33 -0400
Date: Thu, 11 Oct 2001 08:00:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: willy tarreau <wtarreau@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.10-ac11
Message-ID: <20011011080046.C12016@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011011132609.32653.qmail@web20510.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011011132609.32653.qmail@web20510.mail.yahoo.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2001 at 03:26:09PM +0200, willy tarreau wrote:
> >  I also _think_ nothing else needs the include in
> <asm-i386/keyboard.h> so kill that off too.
> 
> indeed, there are some files which need it and don't
> compile
> anymore. You have to leave the include enabled in
> keyboard.h :
> 
> - arch/i386/kernel/dmi_scan.c
> - drivers/char/keyboard.c
> - potentially other files in drivers/char/

Erm, these files should include <linux/pm.h> directly and not expect
something else to pull it in.  Doing a quick grep shows that everything
else does.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
