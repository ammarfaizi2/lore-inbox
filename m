Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbVCDQsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbVCDQsu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 11:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbVCDQqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 11:46:45 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3080 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262938AbVCDQoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 11:44:09 -0500
Date: Fri, 4 Mar 2005 17:44:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, davej@redhat.com, torvalds@osdl.org,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050304164407.GB3327@stusta.de>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org> <20050304113626.E3932@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304113626.E3932@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 11:36:26AM +0000, Russell King wrote:
>...
> Anyway, going back to why -mm doesn't work:
> 
>  arch/arm/kernel/built-in.o(.init.text+0xb64): In function `$a':
>  : undefined reference to `rd_size'
>  make[1]: *** [.tmp_vmlinux1] Error 1
> 
> So "rd_size" got deleted in -mm kernels without reference to anyone else
> who's using it.  Greeeeaaatttt....

Sorry, this was my fault (I made it static and oversaw the ARM usage 
when grep'ing for it).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

