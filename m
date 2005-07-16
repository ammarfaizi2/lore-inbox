Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbVGPHE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVGPHE0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 03:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263384AbVGPHEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 03:04:25 -0400
Received: from [213.184.187.212] ([213.184.187.212]:51461 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S262013AbVGPHEQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 03:04:16 -0400
Message-Id: <200507160703.KAA18276@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: <rhowe@siksai.co.uk>
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
       <linux-xfs@oss.sgi.com>, "'Nathan Scott'" <nathans@sgi.com>
Subject: Re: XFS corruption during power-blackout
Date: Sat, 16 Jul 2005 10:02:41 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcWJ1FuXffNb7HvTTDeY4O4AIvjIuQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Howe wrote: {

XFS only journals metadata, not data.

So, you are supposed to get a consistent filesystem structure, but your
data consistency isn't guaranteed.
}

What did XFS do to detect filedata-corruption before it was added to the
vanilla-kernel?

Maybe it did not update the metadata before the fs was sync'd?

Really, it should wait for fs sync and then update metadata!

This would imply 2 syncs in succession to ensure updated filedata/metadata
consistency, which is OK.

Is it possible to instruct XFS to delay metadata update until after a
filedata sync?

Thanks!

		Al

