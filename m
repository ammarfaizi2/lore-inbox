Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275241AbTHSATA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 20:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275253AbTHSATA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 20:19:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:40376 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275241AbTHSAS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 20:18:58 -0400
Date: Mon, 18 Aug 2003 17:15:02 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: mpm@selenic.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Debug: sleeping function called from invalid context
Message-Id: <20030818171502.65d40693.rddunlap@osdl.org>
In-Reply-To: <20030819001316.GF22433@redhat.com>
References: <20030815101856.3eb1e15a.rddunlap@osdl.org>
	<20030815173246.GB9681@redhat.com>
	<20030815123053.2f81ec0a.rddunlap@osdl.org>
	<20030816070652.GG325@waste.org>
	<20030818140729.2e3b02f2.rddunlap@osdl.org>
	<20030819001316.GF22433@redhat.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 01:13:16 +0100 Dave Jones <davej@redhat.com> wrote:

| On Mon, Aug 18, 2003 at 02:07:29PM -0700, Randy.Dunlap wrote:
|  > | > |  > Debug: sleeping function called from invalid context at include/asm/uaccess.h:473
|  > | > |  > Call Trace:
|  > | > |  >  [<c0120d94>] __might_sleep+0x54/0x5b
|  > | > |  >  [<c010d001>] save_v86_state+0x71/0x1f0
|  > | > |  >  [<c010dbd5>] handle_vm86_fault+0xc5/0xa90
|  > | > |  >  [<c019cab8>] ext3_file_write+0x28/0xc0
|  > | > |  >  [<c011cd96>] __change_page_attr+0x26/0x220
|  > | > |  >  [<c010b310>] do_general_protection+0x0/0x90
|  > | > |  >  [<c010a69d>] error_code+0x2d/0x40
|  > | > |  >  [<c0109657>] syscall_call+0x7/0xb
|  > | > | 
|  > 
|  > I had another occurrence of this yesterday.  It doesn't seem to be
|  > an error condition AFAICT.
| 
| How spooky. now I got one too, (minus the noise).
| 
| Call Trace:
|  [<c0120022>] __might_sleep+0x5b/0x5f
|  [<c010cf8a>] save_v86_state+0x6a/0x1f3
|  [<c010dad2>] handle_vm86_fault+0xa7/0x897
|  [<c010b2ed>] do_general_protection+0x0/0x93
|  [<c010a651>] error_code+0x2d/0x38
|  [<c0109623>] syscall_call+0x7/0xb
| 
| By the looks of the logs, it happened as I restarted X, as theres
| a bunch of mtrr messages right after this..

I don't recall mtrr messages, but it is happening just after I start
X and the window manager with me also.

--
~Randy
"Everything is relative."
