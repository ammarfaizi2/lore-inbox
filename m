Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbVLAOxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbVLAOxJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 09:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbVLAOxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 09:53:09 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:54187 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932257AbVLAOxI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 09:53:08 -0500
Date: Thu, 1 Dec 2005 14:53:07 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Takashi Sato <sho@bsd.tnes.nec.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: stat64 for over 2TB file returned invalid st_blocks
Message-ID: <20051201145307.GF27946@ftp.linux.org.uk>
References: <01e901c5f66e$d4551b70$4168010a@bsd.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01e901c5f66e$d4551b70$4168010a@bsd.tnes.nec.co.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 09:00:26PM +0900, Takashi Sato wrote:
> 2. Change the type of architecture dependent stat64.st_blocks in
>   include/asm/asm-*/stat.h from unsigned long to unsigned long long.
>   I tried modifying only stat64 of 32bit architecture
>   (include/asm-i386/stat.h).

... watch libc have kittens on big-endian architectures subjected
to that treatment.
