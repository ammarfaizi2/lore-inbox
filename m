Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263160AbTDWMQM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 08:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263967AbTDWMQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 08:16:12 -0400
Received: from mail.gmx.de ([213.165.65.60]:62199 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263160AbTDWMQM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 08:16:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Kirilenko <icedank@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Data storing
Date: Wed, 23 Apr 2003 15:28:08 +0300
User-Agent: KMail/1.4.3
References: <200304231459.37955.icedank@gmx.net> <Pine.LNX.4.53.0304230817340.22823@chaos>
In-Reply-To: <Pine.LNX.4.53.0304230817340.22823@chaos>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304231528.08720.icedank@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!


> > I need to make some checks (search for particular BIOS version) in the
> > very start of the kernel. I need to store this data (zero page is pretty
> > good for this, I think) and access it from arch/i386/boot/setup.S,
> > arch/i386/boot/compressed/misc.c and in some other places. Can somebody
> > suggest me good place to put check procedure and how to pass data?
>
> I use 0x000001f0 (absolute) for relocating virtual disk code
> for booting embedded systems. After Linux is up, the code remains
> untouched. This might be a good location because the BIOS doesn't
> use it during POST/boot and Linux (currently) leaves it alone.
> Of course, this doesn't mean that somebody will not destroy this
> area in the future (probably to spite you and me!!!).

Yes, I know about this area, as I wrote (Documentation/i386/zero-page.txt). 
And I even know how to pass parameter from zero-page into kernel space 
(setup.c). But I need to use this parm, I fetched, in both setup.S and misc.c 
(see below). And I don't have any ideas about execute order of setup.S, 
misc.c and setup.c.

Best regards,
Andrew.
