Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbUKWGZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbUKWGZn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 01:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbUKWGXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 01:23:36 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:35722 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262206AbUKWGUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 01:20:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=PTQqiAdW02N+4t1ldCUQnWcdabvT4UDMRcQQYEljcqzYhhxKU6PqnTRGREVi358EUPtPEG/f5Ws8cV/CVMzmB5p4rbXrBOR7fTl5jYZs6KNK7F08twHJFB0dnEz0KgCVeIn06O59detd2p97Ls3RNDCk4bsUh0YBX/kSjVB6+Ag=
Message-ID: <2c59f003041122222038834d7e@mail.gmail.com>
Date: Tue, 23 Nov 2004 11:50:15 +0530
From: Amit Gud <amitgud1@gmail.com>
Reply-To: Amit Gud <amitgud1@gmail.com>
To: Helge Hafting <helge.hafting@hist.no>
Subject: Re: file as a directory
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <41A1FFFC.70507@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <2c59f00304112205546349e88e@mail.gmail.com>
	 <41A1FFFC.70507@hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2004 16:04:28 +0100, Helge Hafting <helge.hafting@hist.no> wrote:

> You won't get .tar or .tar.gz support in the VFS, for a few simple reasons:
> 1. .tar and .tar.gz are complicated formats, and are therefore better
>    left to userland.  

Agreed that .tar.gz is a complicated format, but zlib is already in
the kernel. It _should_ simplify inflate and deflate of files. And as
compared to .gz format, .tar is much simpler, I guess.

> 
>    It is hard to make a guaranteed bug-free decompressor that
>    is efficient and works with a finite amount of memory.  The kernel
>    needs all that - userland doesn't.

I think, finite amount of memory is the concern of worry, not the rest
... if we could rely on zlib.
 
> 2. Both .tar and .gz  file formats may improve with time.  Getting a new
>     version of tar og gunzip is easy enough - getting another compression
>     algorithm into the kernel won't be that easy.

Doesn't zlib in the kernel gets updated as the formats change? If not,
.tar formats would be worth trying first as proof of concept.
 
AG
--
May the source be with you.
