Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263974AbUCZIz1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 03:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbUCZIz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 03:55:27 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:5798 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S263974AbUCZIzU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 03:55:20 -0500
Message-ID: <4063EFA5.5070001@stesmi.com>
Date: Fri, 26 Mar 2004 09:53:57 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: GOTO Masanori <gotom@debian.or.jp>
CC: Matthew Wilcox <willy@debian.org>, Jeff Garzik <jgarzik@pobox.com>,
       Adrian Bunk <bunk@fs.tum.de>, 239952@bugs.debian.org,
       debian-devel@lists.debian.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Binary-only firmware covered by the GPL?
References: <E1B6Izr-0002Ai-00@r063144.stusta.swh.mhn.de>	<20040325082949.GA3376@gondor.apana.org.au>	<20040325220803.GZ16746@fs.tum.de>	<40635DD9.8090809@pobox.com>	<20040326003339.GD25059@parcelfarce.linux.theplanet.co.uk> <81ptb0wh45.wl@omega.webmasters.gr.jp>
In-Reply-To: <81ptb0wh45.wl@omega.webmasters.gr.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi GOTO.

> But think about: why can we distribute assembler only code in linux
> kernel?  It's near to binary form (objdump -d is your friend).

It's not. The difference is that we can always insert another asm
statement anywhere (of course changing the way the function works)
and still have it assemble and unless we goofed up it'll still run.
mov ax,ax for instance won't do a thing. We can insert that
anywhere we wish without changing anything. The assembler will take
care of any relative jumps and pointers but with a binary firmware,
try to insert a byte into it (not CHANGE one, INSERT one), even
if you know just insert a NOP somewhere - and see what happens.

// Stefan
