Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVBDIYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVBDIYN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 03:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262980AbVBDIYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 03:24:12 -0500
Received: from colin2.muc.de ([193.149.48.15]:62218 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261270AbVBDIUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 03:20:53 -0500
Date: 4 Feb 2005 09:20:49 +0100
Date: Fri, 4 Feb 2005 09:20:49 +0100
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3 x86-64 compile err on suse 9.1
Message-ID: <20050204082049.GA33482@muc.de>
References: <3174569B9743D511922F00A0C9431423080853BA@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C9431423080853BA@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 05:13:05PM -0800, YhLu wrote:
>   CC      arch/x86_64/kernel/asm-offsets.s
> arch/x86_64/kernel/asm-offsets.c: In function `main':
> arch/x86_64/kernel/asm-offsets.c:65: error: invalid application of `sizeof'
> to an incomplete type
> arch/x86_64/kernel/asm-offsets.c:66: error: dereferencing pointer to
> incomplete type
> arch/x86_64/kernel/asm-offsets.c:67: error: dereferencing pointer to
> incomplete type
> make[1]: *** [arch/x86_64/kernel/asm-offsets.s] Error 1
> make: *** [arch/x86_64/kernel/asm-offsets.s] Error 2

defconfig seems to compile at least, both SMP and UP.

Try a 
cp .config backup ; make distclean ; cp backup .config ; make oldconfig 
first. Sometimes the build system becomes confused.

If that doesn't help send me your .config.

-Andi
