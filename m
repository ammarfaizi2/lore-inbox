Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbTIIKEv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 06:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbTIIKEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 06:04:51 -0400
Received: from angband.namesys.com ([212.16.7.85]:8908 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S263784AbTIIKEu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 06:04:50 -0400
Date: Tue, 9 Sep 2003 14:04:45 +0400
From: Oleg Drokin <green@namesys.com>
To: phil <phil@research.suspicious.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs error, 2.6.0-test4-mm6
Message-ID: <20030909100445.GA9234@namesys.com>
References: <20030908173821.43165f12.phil@research.suspicious.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908173821.43165f12.phil@research.suspicious.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Sep 08, 2003 at 05:38:21PM -0500, phil wrote:
>  Unable to handle kernel paging request at virtual address 181d2d42
>   printing eip:
>  EIP is at find_inode+0x3c/0x80
>  Call Trace:
>   [sys_pivot_root+13/896] iget5_locked+0x6d/0xf0
>   [reiserfs_readdir+1216/1360] reiserfs_find_actor+0x0/0
> x30
>   [reiserfs_encode_fh+8/192] reiserfs_find_entry+0xb8/0x
> 160
>   [reiserfs_readdir+912/1360] reiserfs_init_locked_inode
> +0x0/0x20
>   [reiserfs_readdir+1216/1360] reiserfs_find_actor+0x0/0
> x30
>   [reiserfs_readdir+1336/1360] reiserfs_iget+0x48/0xb0
>   [reiserfs_readdir+1216/1360] reiserfs_find_actor+0x0/0
> x30
>   [reiserfs_readdir+912/1360] reiserfs_init_locked_inode
> +0x0/0x20
>   [reiserfs_new_directory+35/560] reiserfs_lookup+0x133/
> 0x180

This looks like some inode list corruption to me.
Any details about the system and kernel config? CONFIG_PREEMPT, I guess?

Bye,
    Oleg
