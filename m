Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267378AbTGHOcG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 10:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267380AbTGHOcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 10:32:06 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:38412 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S267378AbTGHObv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 10:31:51 -0400
To: Sancho Dauskardt <sda@bdit.de>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: FAT statfs loop abort on read-error
References: <20030706102410.2becd137.rddunlap@osdl.org>
	<5.0.2.1.2.20030704123653.03140b70@pop.puretec.de>
	<20030706102410.2becd137.rddunlap@osdl.org>
	<5.0.2.1.2.20030708142409.03e19c60@pop.kundenserver.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 08 Jul 2003 23:46:11 +0900
In-Reply-To: <5.0.2.1.2.20030708142409.03e19c60@pop.kundenserver.de>
Message-ID: <87wuetnkjw.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sancho Dauskardt <sda@bdit.de> writes:

> >I don't know anybody ported dmsdos to 2.4. The cvf stuff was removed
> >and many error handlings was fixed on 2.5.x. So, personally I think to
> >remove the cvf stuff and backport the some parts of fat driver to 2.4
> >is good.
> 
> OK, the 100k diff between 2.4.21/fs/fat and 2.5.74 didn't really help
> me understand what's really changed (other than the cvf removal).
> Should I attempt to brute-force backport fs/fat/* in one large patch,
> or incrementally re-apply the 2.5 changes to 2.4 ?

I submited the some patch to marcelo several times about one year ago,
however, unfortunately those patches was ignored.

So, one large patch may not be applied. And incremental ways is more
safety, I think. (Probably, we need to address the difference of vfs
and umsdos)

> Or, as you write 'some parts', which parts would that be ?

I thought that the patches of only bug fix is probably easy to be
applied.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
