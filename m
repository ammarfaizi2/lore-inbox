Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbTKYIRE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 03:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTKYIRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 03:17:04 -0500
Received: from mail.jambit.de ([212.18.21.206]:36882 "EHLO mail.jambit.de")
	by vger.kernel.org with ESMTP id S262104AbTKYIRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 03:17:01 -0500
Message-ID: <020001c3b32c$70607b50$c100a8c0@wakatipu>
From: "Michael Kerrisk" <mtk-lists@jambit.com>
To: <dhruv.anand@wipro.com>
Cc: <linux-kernel@vger.kernel.org>
References: <1E27FF611EBEFB4580387FCB5BEF00F3013DEF08@blr-ec-msg04.wipro.com>
Subject: Re: DIRECT IO for ext3/ext2.
Date: Tue, 25 Nov 2003 09:16:34 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for your reply. I looked into the boundary alignment issue.
> Observed something strange happening;
>
> I wrote my own kernel module and then;
> 1. retrieved the block size = 4096 using block_size(struct block_device
> *bdev)
> 2. in the user application i did a lseek by 4906 (block size seek)
> 3. then found the address of the variable i wanted to read into, to be
> block
>    size aligned.
>
> However, the read still seems to fail with the O_DIRECT flag specified.
> The same check _passes if i do not specify the flag in open of the
> device.
>
> Boundary issues seem to be not the cause of failure here.
> Would have any more kind suggestions on something that i should do or
> could be missing on?

Is the size of the data you are reading also a multiple the block size?  (It
should be.)

Cheers,

Michael

