Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265950AbUGEFCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265950AbUGEFCi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 01:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbUGEFCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 01:02:38 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:6409 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S265950AbUGEFCg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 01:02:36 -0400
To: Ali Akcaagac <aliakc@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] FAT broken in 2.6.7-bk15
References: <1088979061.1277.6.camel@localhost>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 05 Jul 2004 14:02:32 +0900
In-Reply-To: <1088979061.1277.6.camel@localhost>
Message-ID: <87smc7yrkn.fsf@ibmpc.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ali Akcaagac <aliakc@web.de> writes:

> The only thing NLS changes in a filesystem is special charakters for
> filenames but it doesn't change the technical structure of the FS
> itself so in worst case I only get some strange characters shown in
> filenames.

No, it's very unuseful. Probably it can't lookup, and it has possible
of filesystem corruption if you write.

If you want to do it, just read/write the partition directly.


> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"

You configured these, so fatfs will try to use it.

> # CONFIG_NLS_CODEPAGE_437 is not set
> CONFIG_NLS_CODEPAGE_850=m
> # CONFIG_NLS_ISO8859_1 is not set
> CONFIG_NLS_ISO8859_15=m

But you didn't install these. So fatfs couldn't do what you specified,
then fatfs logged it and returns error.

Looks like you want to the following config.

CONFIG_FAT_DEFAULT_CODEPAGE=850
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-15"
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
