Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbUKISmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbUKISmN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 13:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbUKISmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 13:42:12 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:31503 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261610AbUKISlr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 13:41:47 -0500
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Move check for invalid chars to
 vfat_valid_longname()
References: <41901DD1.mail5VX1GOOYK@lsrfire.ath.cx>
	<20041109013524.GB6835@neapel230.server4you.de>
	<87actr5ak8.fsf@devron.myhome.or.jp> <4190EED2.5040906@lsrfire.ath.cx>
	<87is8fj5o7.fsf@devron.myhome.or.jp>
	<20041109182224.GA15288@neapel230.server4you.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 10 Nov 2004 03:41:32 +0900
In-Reply-To: <20041109182224.GA15288@neapel230.server4you.de> (Rene
 Scharfe's message of "Tue, 9 Nov 2004 19:22:24 +0100")
Message-ID: <874qjylvab.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> But doesn't imply this we can't do any of our checks on the VFS
> string?

Basically yes.

> A dot (0x2E) at the end of a filename could be the half of some other
> character in some encoding, right?

'.'/' ' is not contained as second byte by any encodings, at least
current nls is supporting encodings.

> And the same could be said about the checks in
> vfat_valid_longname(), no?

These are string, not char. These should be unique.

> The patch you asked for converting IS_BADCHAR to an inline function
> follows. I rolled it together with the other conversions from patch 3.
> Applies directly on top of 2.6.10-rc1-bk18.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
