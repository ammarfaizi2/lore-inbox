Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264943AbUAaRUE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 12:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbUAaRUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 12:20:04 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:33549 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S264943AbUAaRUB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 12:20:01 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH to access old-style FAT fs
References: <20040126173949.GA788@frodo.local>
	<20040128202443.GA9246@frodo.local>
	<87bron7ppd.fsf@devron.myhome.or.jp>
	<20040129105624.GA1072@frodo.local> <bvf3b3$6pr$2@terminus.zytor.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 01 Feb 2004 02:19:54 +0900
In-Reply-To: <bvf3b3$6pr$2@terminus.zytor.com>
Message-ID: <87hdycujb9.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> This is of course dangerous, since it could create conflicts.
> 
> Thus, I suggest we do write new 0x00 markers; even though it's not
> required (it only matters if the filesystem is out of spec and
> therefore by definition corrupt), it would help the Psion, and
> wouldn't cause any problems for in-spec filesystems.

Yes, that cluster is dangerous. However, repair should be fsck's
job. IMO, for repair we shouldn't add unneeded I/O to normal path.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
