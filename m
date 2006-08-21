Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422699AbWHUQv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422699AbWHUQv7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 12:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422703AbWHUQv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 12:51:59 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34059 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422699AbWHUQv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 12:51:58 -0400
Date: Mon, 21 Aug 2006 18:51:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm2: m68k nsproxy compile breakage
Message-ID: <20060821165158.GK11651@stusta.de>
References: <20060819220008.843d2f64.akpm@osdl.org> <20060821020843.GG11651@stusta.de> <20060821144649.GA5573@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821144649.GA5573@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 09:46:49AM -0500, Serge E. Hallyn wrote:
> Quoting Adrian Bunk (bunk@stusta.de):
> > namespaces-utsname-implement-utsname-namespaces.patch causes the 
> > following compile error on m68k:
> > 
> > <--  snip  -->
> > 
> > ...
> >   LD      .tmp_vmlinux1
> > arch/m68k/kernel/built-in.o: In function `sys_call_table':
> > (.data+0x91c): undefined reference to `init_nsproxy'
> > 
> > <--  snip  -->
> > 
> > Is there a reason why struct init_nsproxy can't reside in 
> > kernel/nsproxy.c?
> 
> Apparently not.  The following patch compiles and boots fine on s390.
>...

Thanks, I can confirm it fixes this compile error on m68k.

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

