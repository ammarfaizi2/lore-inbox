Return-Path: <linux-kernel-owner+w=401wt.eu-S965264AbXAJXF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965264AbXAJXF1 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 18:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965270AbXAJXF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 18:05:26 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:38297 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965264AbXAJXFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 18:05:25 -0500
Date: Wed, 10 Jan 2007 23:56:08 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Olaf Hering <olaf@aepfle.de>
cc: Linus Torvalds <torvalds@osdl.org>, Jean Delvare <khali@linux-fr.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Andrey Borzenkov <arvidjaar@mail.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: .version keeps being updated
In-Reply-To: <20070110200249.GA30676@aepfle.de>
Message-ID: <Pine.LNX.4.61.0701102352400.28885@yvahk01.tjqt.qr>
References: <20070109102057.c684cc78.khali@linux-fr.org>
 <20070109170550.AFEF460C343@tzec.mtu.ru> <20070109214421.281ff564.khali@linux-fr.org>
 <Pine.LNX.4.64.0701101426400.14458@scrub.home> <20070110181053.3b3632a8.khali@linux-fr.org>
 <Pine.LNX.4.64.0701101058200.3594@woody.osdl.org> <20070110193136.GA30486@aepfle.de>
 <20070110200249.GA30676@aepfle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Jan 10 2007 21:02, Olaf Hering wrote:
>On Wed, Jan 10, Olaf Hering wrote:
>
>with such a change, it will always be first. Tested on powerpc.
>I could even add an ELF parser and look for the first bytes in the
>.rodata section.

With such a change, you would not need to grep for it. You could use
binutils on it. `objdump -sj .rodata.uts vmlinux` would be a start.
Maybe not the prettiest output, but guaranteed to contain only the
banner.


	-`J'
-- 
