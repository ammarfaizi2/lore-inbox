Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbTCEV3b>; Wed, 5 Mar 2003 16:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbTCEV3b>; Wed, 5 Mar 2003 16:29:31 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:13199 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S264940AbTCEV3a>; Wed, 5 Mar 2003 16:29:30 -0500
Date: Wed, 5 Mar 2003 15:39:51 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: ravikumar.chakaravarthy@amd.com
cc: mbligh@aracnet.com, <linux-kernel@vger.kernel.org>
Subject: RE: Loading and executing kernel from a non-standard address usin
 g SY SLINUX
In-Reply-To: <99F2150714F93F448942F9A9F112634CA54B08@txexmtae.amd.com>
Message-ID: <Pine.LNX.4.44.0303051536250.31461-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Mar 2003 ravikumar.chakaravarthy@amd.com wrote:

> Yes the kernel is uncompressed to the right location (0x200000), in my
> case. When I try to uncompress it to a non standard address (other than
> 0x100000), the address mapping is affected. Thats why I tried to change
> the PAGE_OFFSET value to 0xc0100000, which should be the right value
> corresponding to (0x200000).

> So the problem now is that, when a function is invoked it is unable to
> fetch the right physical address, since my address mapping (System.map)
> does not change when I change the value of PAGE_OFFSET and recompile the
> kernel.

Well, this sounds very much like your vmlinux is relocated to the wrong 
adresses, and then it's not surprising it doesn't work. You definitely 
want to change arch/i386/vmlinux.lds.S. I'm not sure if you actually want 
to change PAGE_OFFSET, but I don't see a fundamental reason why it should 
be needed, so I think you should try as-is.

--Kai


