Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbUKIQA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbUKIQA0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 11:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUKIQAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 11:00:25 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:17165 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261564AbUKIQAN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 11:00:13 -0500
To: lsr@neapel230.server4you.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] Return better error codes from
 vfat_valid_longname()
References: <41901DD1.mail5VX1GOOYK@lsrfire.ath.cx>
	<20041109013848.GC6835@neapel230.server4you.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 10 Nov 2004 00:28:39 +0900
In-Reply-To: <20041109013848.GC6835@neapel230.server4you.de> (lsr@neapel230.server4you.de's
 message of "Tue, 9 Nov 2004 02:38:48 +0100")
Message-ID: <87vfcf3uu0.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lsr@neapel230.server4you.de writes:

> Currently vfat returns -EINVAL if one tries to create a file or directory
> with an invalid name. This patch changes vfat_valid_longname() to return
> a more specific error code.
>
> POSIX doesn't define a nice error code for invalid filenames, so I chose
> EACCES -- unlike EINVAL this is a valid error code of mkdir(2). Hope it
> sort of fits. (EINVAL did *not* fit; it generally seems to point to
> problems not with the filename  but with e.g. the flags value of open(2)
> etc.).

Yes, the error code for this should be consistent on _system_.
Until we do it, this change would not be useful.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
