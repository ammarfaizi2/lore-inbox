Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUJ0NGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUJ0NGs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 09:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbUJ0NFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 09:05:13 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:32779 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262428AbUJ0NDU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 09:03:20 -0400
To: cw@f00f.org (Chris Wedgwood)
Cc: LKML <linux-kernel@vger.kernel.org>,
       Chris Wedgwood <cw@taniwha.stupidest.org>
Subject: Re: [RFC] Rename SECTOR_SIZE to MSDOS_SECTOR_SIZE
References: <20041027060837.GB32396@taniwha.stupidest.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 27 Oct 2004 22:03:06 +0900
In-Reply-To: <20041027060837.GB32396@taniwha.stupidest.org> (Chris
 Wedgwood's message of "Tue, 26 Oct 2004 23:08:37 -0700")
Message-ID: <878y9ss48l.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cw@f00f.org (Chris Wedgwood) writes:

> -#define SECTOR_SIZE	512		/* sector size (bytes) */
> -#define SECTOR_BITS	9		/* log2(SECTOR_SIZE) */
> +#define MSDOS_SECTOR_SIZE	512	/* sector size (bytes) */
> +#define MSDOS_SECTOR_BITS	9	/* log2(SECTOR_SIZE) */
>  #define MSDOS_DPB	(MSDOS_DPS)	/* dir entries per block */
>  #define MSDOS_DPB_BITS	4		/* log2(MSDOS_DPB) */
> -#define MSDOS_DPS	(SECTOR_SIZE / sizeof(struct msdos_dir_entry))
> +#define MSDOS_DPS	(MSDOS_SECTOR_SIZE / sizeof(struct msdos_dir_entry))
>  #define MSDOS_DPS_BITS	4		/* log2(MSDOS_DPS) */

The fatfs doesn't use these (is separated by two blank lines).
These are for just backward compatibility.

To rename is not useful at all, please delete instead if it's needed.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
