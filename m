Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266529AbUBLSlN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 13:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266535AbUBLSlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 13:41:13 -0500
Received: from grassmarket.ucs.ed.ac.uk ([129.215.166.64]:45227 "EHLO
	grassmarket.ucs.ed.ac.uk") by vger.kernel.org with ESMTP
	id S266529AbUBLSlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 13:41:11 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Reply-To: s0348365@sms.ed.ac.uk
Organization: University of Edinburgh
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.3-rc2-mm1
Date: Thu, 12 Feb 2004 18:43:54 +0000
User-Agent: KMail/1.6
References: <20040212015710.3b0dee67.akpm@osdl.org>
In-Reply-To: <20040212015710.3b0dee67.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402121843.55084.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 February 2004 09:57, you wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3-rc2/2.6
>.3-rc2-mm1/
>
>
> - Added the big ISDN update
>
> - Device Mapper update
>
[snip]

I don't know if it's still worth reporting these, but at the risk of sounding 
like a broken record..

Badness in interruptible_sleep_on at kernel/sched.c:2235
Call Trace:
 [<c011b289>] interruptible_sleep_on+0xe9/0x120
 [<c011ae80>] default_wake_function+0x0/0x20
 [<c0365c17>] copy_block+0xa7/0xe0
 [<c036167c>] emu10k1_audio_write+0x1ac/0x320
 [<c03614d0>] emu10k1_audio_write+0x0/0x320
 [<c015370a>] vfs_write+0x10a/0x150
 [<c010f26a>] do_gettimeofday+0x1a/0xb0
 [<c0153802>] sys_write+0x42/0x70
 [<c03f0266>] sysenter_past_esp+0x43/0x65

Haven't noticed it before.

Other than that, the whole ACPI on nForce2 thing seems to have been fixed. 
Back to -mm for me.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    7/10 Darroch Court,
            University of Edinburgh.
