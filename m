Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130534AbRBRMoG>; Sun, 18 Feb 2001 07:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132309AbRBRMn4>; Sun, 18 Feb 2001 07:43:56 -0500
Received: from [212.17.18.2] ([212.17.18.2]:27403 "EHLO technoart.net")
	by vger.kernel.org with ESMTP id <S130534AbRBRMno>;
	Sun, 18 Feb 2001 07:43:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Denis Perchine <dyp@perchine.com>
To: linux-kernel@vger.kernel.org
Subject: Re: fsync vs fdatasync on Linux
Date: Sun, 18 Feb 2001 18:41:59 +0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <01021818225902.00766@dyp.perchine.com>
In-Reply-To: <01021818225902.00766@dyp.perchine.com>
MIME-Version: 1.0
Message-Id: <01021818415903.00766@dyp.perchine.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 February 2001 18:22, Denis Perchine wrote:
> Hello,
>
> as fas as I can see from fdatasync man page, and from the latest kernel
> sources (2.4.1ac3, fs/buffer.c), they are equivalent.
>
> Using of fdatasync in database can gain significant gain on systems which
> supports it (on HP it gains up to 25% with pg_bench on PostgreSQL 7.1b5).
>
> Are there any plans to implement this correctly? And due to what problems
> it was not implemented yet?

Forget this crap. Seems I missed these lines:
err = file->f_op->fsync(file, dentry, 0);
err = file->f_op->fsync(file, dentry, 1);

-- 
Sincerely Yours,
Denis Perchine

----------------------------------
E-Mail: dyp@perchine.com
HomePage: http://www.perchine.com/dyp/
FidoNet: 2:5000/120.5
----------------------------------
