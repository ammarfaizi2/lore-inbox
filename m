Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282525AbRLRNBG>; Tue, 18 Dec 2001 08:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281916AbRLRNA4>; Tue, 18 Dec 2001 08:00:56 -0500
Received: from mail.zmailer.org ([194.252.70.162]:39552 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S282525AbRLRNAm>;
	Tue, 18 Dec 2001 08:00:42 -0500
Date: Mon, 17 Dec 2001 03:00:28 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: dd of=blkdev seek=123 -> EINVAL ??
Message-ID: <20011217030028.B1145@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With recent dd and 2.4.17rc1 an attempt to write (with DD)
into a block-device yields  EINVAL error.

Doing   strace   shows that it comes from   ftruncate64()
on the opened device.

Should there be some other error code ?   EBLKDEV ?
Or is the dd (4.0p) at fault, and it should either
not ask for the ftruncate*() at all, or ignore its error ?

/Matti Aarnio
