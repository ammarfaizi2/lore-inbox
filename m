Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbWEUWDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWEUWDU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 18:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWEUWDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 18:03:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9383 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964887AbWEUWDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 18:03:19 -0400
Date: Sun, 21 May 2006 15:02:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: 2.6.17-rc4-mm2
Message-Id: <20060521150259.3a1bdc9e.akpm@osdl.org>
In-Reply-To: <446F3D6D.10704@mbligh.org>
References: <446F3D6D.10704@mbligh.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>
> Panic on boot on 2-way PPC64
>  http://test.kernel.org/abat/32360/debug/console.log
> 
>  Bad page state in process 'idle'
>  page:c0000000010c3100 flags:0x0003300000000000 mapping:0000000000000000 
>  mapcount:0 count:0
>  Trying to fix it up, but a reboot is needed
>  Backtrace:
>  Call Trace:
>  [C0000000004CBB70] [C00000000000EEE8] .show_stack+0x74/0x1b4 (unreliable)
>  [C0000000004CBC20] [C000000000098D04] .bad_page+0x80/0x134
>  [C0000000004CBCB0] [C000000000099F28] .__free_pages_ok+0x134/0x280
>  [C0000000004CBD70] [C00000000039C4F8] .free_all_bootmem_core+0x15c/0x320
>  [C0000000004CBE50] [C0000000003923AC] .mem_init+0xc0/0x294
>  [C0000000004CBEF0] [C000000000385700] .start_kernel+0x208/0x300
>  [C0000000004CBF90] [C000000000008594] .start_here_common+0x88/0x8c

I dunno, Martin.  I obviously need to resurrect the
takes-seven-minutes-to-boot pseries machine here, but I need to get -mm3
out without Mel's patches to see how much that fixes.  So if you could test
-mm3 and if that fixes it then we have a likely culprit.
