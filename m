Return-Path: <linux-kernel-owner+w=401wt.eu-S1750837AbXAJXfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbXAJXfY (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 18:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965241AbXAJXfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 18:35:24 -0500
Received: from gate.crashing.org ([63.228.1.57]:46456 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965239AbXAJXfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 18:35:23 -0500
In-Reply-To: <Pine.LNX.4.61.0701102352400.28885@yvahk01.tjqt.qr>
References: <20070109102057.c684cc78.khali@linux-fr.org> <20070109170550.AFEF460C343@tzec.mtu.ru> <20070109214421.281ff564.khali@linux-fr.org> <Pine.LNX.4.64.0701101426400.14458@scrub.home> <20070110181053.3b3632a8.khali@linux-fr.org> <Pine.LNX.4.64.0701101058200.3594@woody.osdl.org> <20070110193136.GA30486@aepfle.de> <20070110200249.GA30676@aepfle.de> <Pine.LNX.4.61.0701102352400.28885@yvahk01.tjqt.qr>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <acfe3f410c8bae877412655797a15e17@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: Roman Zippel <zippel@linux-m68k.org>, Andy Whitcroft <apw@shadowen.org>,
       Andrew Morton <akpm@osdl.org>, Olaf Hering <olaf@aepfle.de>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Jean Delvare <khali@linux-fr.org>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Andrey Borzenkov <arvidjaar@mail.ru>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: .version keeps being updated
Date: Thu, 11 Jan 2007 00:35:06 +0100
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With such a change, you would not need to grep for it. You could use
> binutils on it. `objdump -sj .rodata.uts vmlinux` would be a start.
> Maybe not the prettiest output, but guaranteed to contain only the
> banner.

objcopy -j .rodata.uts -O binary vmlinux >(the-checker-script)


Segher

