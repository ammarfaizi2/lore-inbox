Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVEAK1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVEAK1x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 06:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVEAK1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 06:27:53 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:23951 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261584AbVEAK1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 06:27:41 -0400
Date: Sun, 1 May 2005 12:27:37 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm2
Message-ID: <20050501102737.GB9739@ens-lyon.fr>
References: <200505011010.j41AA1dC026127@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505011010.j41AA1dC026127@harpo.it.uu.se>
User-Agent: Mutt/1.5.8i
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2005 at 12:10:01PM +0200, Mikael Pettersson wrote:
> On Sun, 1 May 2005 02:27:49 +0200, Benoit Boissinot wrote:
> >This time it boots correctly, but it oops:
> ...
> >[   37.738020] EIP is at do_proc_dointvec_conv+0x11/0x50
> >[   37.741173] eax: 00000001   ebx: 00000001   ecx: 40adb814   edx: df8f2f08
> >[   37.744357] esi: b7dab001   edi: df8f2eef   ebp: df8f2ec0   esp: df8f2ec0
> >[   37.747592] ds: 007b   es: 007b   ss: 0068
> >[   37.750861] Process sysctl (pid: 5336, threadinfo=df8f2000 task=decbf070)
> >[   37.750986] Stack: df8f2f1c c012046c 00000001 00000000 00000001
> >df25f6ac 00000001 40adb814
> >[   37.754460]        00000001 00000001 00000000 31cf44c0 df8f000a
> >c01154ec 00000001 df603f38
> >[   37.758018]        00000006 df8f2ef0 00000001 00000000 b7dab000
> >b7dab000 00000001 df8f2f3c
> >[   37.761703] Call Trace:
> >[   37.768905]  [<c0103d66>] show_stack+0xa6/0xe0
> >[   37.772695]  [<c0103f1b>] show_registers+0x15b/0x1f0
> >[   37.776529]  [<c010410b>] die+0xbb/0x140
> >[   37.780393]  [<c0115493>] do_page_fault+0x233/0x6cc
> >[   37.784313]  [<c0103993>] error_code+0x4f/0x54
> >[   37.788247]  [<c012046c>] do_proc_dointvec+0x29c/0x320
> >[   37.792260]  [<c012051c>] proc_dointvec+0x2c/0x40
> >[   37.796289]  [<c011fea5>] do_rw_proc+0x85/0x90
> >[   37.800321]  [<c011ff21>] proc_writesys+0x21/0x30
> >[   37.804359]  [<c0154f58>] vfs_write+0x98/0x140
> >[   37.808446]  [<c01550ad>] sys_write+0x3d/0x70
> >[   37.812544]  [<c0102e8f>] sysenter_past_esp+0x54/0x75
> 
> This looks exactly like the effect of the gcc-4.0 miscompilation
> of net/ipv4/devinet.c I reported 8 days ago.
> 
> Are you using gcc-4.0? If so, don't, or at least upgrade to the
> latest snapshot which should include a fix.
> 

Yes i am using gcc-4.0, i will try a newer snapshot as soon as possible.

> /Mikael

thanks,

Benoit
-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
