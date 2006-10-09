Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWJIQrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWJIQrM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 12:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbWJIQrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 12:47:12 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:18388 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932112AbWJIQrK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 12:47:10 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in the kernel [try #4]
Date: Mon, 9 Oct 2006 18:47:03 +0200
User-Agent: KMail/1.9.4
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Howells <dhowells@redhat.com>,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, sfr@canb.auug.org.au,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
References: <Pine.LNX.4.61.0610062250090.30417@yvahk01.tjqt.qr> <200610091727.34780.arnd.bergmann@de.ibm.com> <Pine.LNX.4.62.0610091729420.16048@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0610091729420.16048@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610091847.05441.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 October 2006 17:31, Geert Uytterhoeven wrote:
> Well, I meant that of course you have to include <stdint.h> at the top of
> <linux/types.h>. I just thought inside that particular #ifdef wasn't the right
> place.
> 

That has the potential of breaking other source files that don't expect
linux/types.h to bring in the whole stdint.h file.

Also, it may break some other linux header files that include <linux/types.h>
and expect to get stuff like uid_t, which you don't get if a glibc header is
included first, because of __KERNEL_STRICT_NAMES.

	Arnd <><
