Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261618AbTCGPSI>; Fri, 7 Mar 2003 10:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261621AbTCGPSI>; Fri, 7 Mar 2003 10:18:08 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:2965 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261618AbTCGPSH>; Fri, 7 Mar 2003 10:18:07 -0500
Date: Fri, 7 Mar 2003 09:27:07 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: David Woodhouse <dwmw2@infradead.org>
cc: Arun Prasad <arun@netlab.hcltech.com>, <linux-kernel@vger.kernel.org>,
       <torvalds@transmeta.com>
Subject: Re: 2.5.51 CRC32 undefined
In-Reply-To: <1047040816.32200.59.camel@passion.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.44.0303070922580.26430-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Mar 2003, David Woodhouse wrote:

> The problem is that crc32.o isn't actually linked into the kernel,
> because no symbols from it are referenced when the linker is asked to
> pull in lib/lib.a
> 
> Set CONFIG_CRC32=m. We probably shouldn't allow it to be set to 'Y' in
> the first place., given the above.

I think it'd be much nicer to just make it work, which can easily be done 
by moving the EXPORT_SYMBOL() to kernel/ksyms.c. Or, just move the entire 
file into kernel/ (which unfortunately isn't a very natural place for it. 
The real problem is that we need a lib/dont_drop_unreferenced/)

--Kai

