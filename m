Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266362AbUHYWcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUHYWcb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266173AbUHYWXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:23:05 -0400
Received: from cantor.suse.de ([195.135.220.2]:700 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265093AbUHYWR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 18:17:58 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>,
       "Christian T. Steigies" <cts@debian.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: kernel-image-2.6.7
References: <20040809073126.GA4669@skeeve>
	<Pine.LNX.4.58.0408221129590.25793@anakin>
	<Pine.LNX.4.58.0408221145090.25793@anakin>
	<20040822101914.GA7480@skeeve>
	<Pine.GSO.4.58.0408221224310.12638@waterleaf.sonytel.be>
	<Pine.LNX.4.58.0408221333460.13834@anakin>
	<4128C3F4.6070507@linux-m68k.org>
	<Pine.GSO.4.58.0408230947190.29370@waterleaf.sonytel.be>
	<Pine.GSO.4.58.0408252214080.28854@waterleaf.sonytel.be>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Yow!!  It's LIBERACE and TUESDAY WELD!!  High on a HILL... driving a
 LITTLE CAR...  I wanna be in that LITTLE CAR, too!!  I wanna drive off
 with LIBBY and TUESDAY!
Date: Thu, 26 Aug 2004 00:17:56 +0200
In-Reply-To: <Pine.GSO.4.58.0408252214080.28854@waterleaf.sonytel.be> (Geert
 Uytterhoeven's message of "Wed, 25 Aug 2004 22:50:36 +0200 (MEST)")
Message-ID: <je4qmqx3or.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> So it goes wrong during this step:
>
> | m68k-linux-ld -r -o x.o arch/m68k/kernel/.tmp_setup.o -T \
> | arch/m68k/kernel/.tmp_setup.ver
>
> | anakin$ cat arch/m68k/kernel/.tmp_setup.ver
> | __crc_mach_heartbeat = 0x39638af7 ;
> | anakin$
>
> Does the above look like a valid linker file? `mach_heartbeat' is indeed the
> only exported symbol in arch/m68k/kernel/setup.c.

Looks correct.  If anything goes wrong then it must be the ld -r call.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
