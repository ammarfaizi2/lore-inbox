Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbULHJQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbULHJQE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 04:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbULHJQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 04:16:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:48075 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261161AbULHJQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 04:16:03 -0500
Date: Wed, 8 Dec 2004 01:15:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Greaves <david@dgreaves.com>
Cc: phil@dier.us, linux-kernel@vger.kernel.org
Subject: Re: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm,
 and xfs
Message-Id: <20041208011546.2d509d1b.akpm@osdl.org>
In-Reply-To: <41B6C34B.7030700@dgreaves.com>
References: <20041122130622.27edf3e6.phil@dier.us>
	<20041122161725.21adb932.akpm@osdl.org>
	<20041124094549.4c51d6d5.phil@dier.us>
	<20041124151234.714f30d4.akpm@osdl.org>
	<41A9B693.30905@dgreaves.com>
	<20041128102751.2dac71f7.akpm@osdl.org>
	<41B6C34B.7030700@dgreaves.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Greaves <david@dgreaves.com> wrote:
>
> I did as you suggested and it's been fine until I got this last night.
> 
>  Dec  8 06:50:04 cu kernel: slab: Internal list corruption detected in 
>  cache 'vm_area_struct'(41), slabp cfedd000(13).

That's totally different from the previous oops (it was in dcache).

I'd be suspecting either a random memory scribble or flakey hardware.  It
could well be the latter if you're not using any unusual
drivers/filesystems/etc.

