Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270596AbTGZSFT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 14:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270605AbTGZSFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 14:05:18 -0400
Received: from holomorphy.com ([66.224.33.161]:62140 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S270596AbTGZSFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 14:05:13 -0400
Date: Sat, 26 Jul 2003 11:21:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1-wl1A: bad: scheduling while atomic!
Message-ID: <20030726182143.GZ15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <1059217886.611.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059217886.611.1.camel@teapot.felipe-alfaro.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 26, 2003 at 01:11:27PM +0200, Felipe Alfaro Solana wrote:
> bad: scheduling while atomic!
> Call Trace:
>  [<c01166b2>] schedule+0x3d2/0x3e0
>  [<c0116a18>] wait_for_completion+0x78/0xd0
>  [<c0116710>] default_wake_function+0x0/0x30
>  [<c0116710>] default_wake_function+0x0/0x30
>  [<c015eda8>] link_path_walk+0x828/0x8d0
>  [<c0129c71>] synchronize_kernel+0x31/0x40
>  [<c01d0fdb>] poke_blanked_console+0x6b/0x80
>  [<c0129c30>] wakeme_after_rcu+0x0/0x10
>  [<c016c55d>] detach_mnt+0x3d/0x70
>  [<c016d623>] do_move_mount+0x213/0x250

I wasn't sure what the right way to fix this was, so I punted, as it's
harmless at boot-time. There are somewhat more severe issues floating
around I need to fix, maybe sometime after OLS.


-- wli
