Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265146AbUADJII (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 04:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265147AbUADJIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 04:08:07 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:60432 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S265146AbUADJID
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 04:08:03 -0500
To: andersen@codepoet.org
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH] FAT: Support the large partition (> 128GB) for 2.4
References: <87k74or58m.fsf@devron.myhome.or.jp>
	<20031231091359.GA13996@codepoet.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 04 Jan 2004 18:07:35 +0900
In-Reply-To: <20031231091359.GA13996@codepoet.org>
Message-ID: <87d6a0rsiw.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen <andersen@codepoet.org> writes:

> > This is used for updates (not create) of the directory entry, and
> > overflowed by large partition (> 128GB).
> 
> I think this additional fat32 patch would be a good idea for
> 2.4.x.  Could you review these changes and perhaps fold them into
> your patch for inclusion into 2.4.x.  This patch fixes support
> for the full 4GB (-1 bytes) allowable fat32 file size, and should
> be added onto of your previous patch for large fat32 filesystems.

Basically looks good. But it was forgetting to fix the mmu_private of
some filesystems.

If previous patch was applied and someone didn't submit this stuff,
I'll try it.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
