Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266014AbUA1UIr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 15:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266027AbUA1UIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 15:08:47 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:19731 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S266014AbUA1UIp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 15:08:45 -0500
To: Frodo Looijaard <frodol@dds.nl>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH to access old-style FAT fs
References: <20040126173949.GA788@frodo.local>
	<bv3qb3$4lh$1@terminus.zytor.com> <87n0898sah.fsf@devron.myhome.or.jp>
	<4016B316.4060304@zytor.com> <87ad4987ti.fsf@devron.myhome.or.jp>
	<20040128115655.GA696@arda.frodo.local>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 29 Jan 2004 05:08:32 +0900
In-Reply-To: <20040128115655.GA696@arda.frodo.local>
Message-ID: <87y8rr7s5b.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frodo Looijaard <frodol@dds.nl> writes:

> As I said, I *think* it is safe to have my patch always applied (that
> is, stop when DIR_Name[0] == 0, and be careful to add a new DIR_Name[0] = 0
> entry when new entries are added at the back). It would conform to the
> standard.  But I would not really be surprised if there was yet another
> FAT implementation somewhere out there that breaks the standard in some
> other subtle way, which works now but exhibits problems with my patch.
> That is why I made it a mount option.

"stop when DIR_Name[0] == 0" should be added after cleanup. The option
is not needed.

Honestly, I wouldn't like to add the "add a new DIR_Name[0] = 0" part.
The option is added easy, but it is not removed easy. And we must
maintain it.  (BTW, looks like that patch is buggy)

Those stuff makes a change of the normal path difficult really. At the
same reason, I removed the fat_cvf stuff.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
