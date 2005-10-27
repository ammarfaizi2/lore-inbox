Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbVJ0PFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbVJ0PFn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 11:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbVJ0PFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 11:05:43 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:41088 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750917AbVJ0PFm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 11:05:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jd17TxzPCip1jyBOgaRAouWpE1j02NzVdznSHrQ/Nh+sp16MBKvmZhHTAn+NdHZomDMwj6h8EgzdwdW4WPWu7AjHxuBIKU/R8WCS8jxZqtKzuFKRQ93ezfBfvC0ZaxdMybynq0+2anfYXIINxPfSJGZTvCTL6Eei6Ic6GGbqx/w=
Message-ID: <35fb2e590510270805h1739b19chf0b719948aa6f4f@mail.gmail.com>
Date: Thu, 27 Oct 2005 16:05:39 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il>
Subject: Re: Weirdness of "mount -o remount,rw" with write-protected floppy
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4360C0A7.4050708@weizmann.ac.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4360C0A7.4050708@weizmann.ac.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/05, Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il> wrote:

> # mount /dev/fd0 /mnt/floppy/
> mount: block device /dev/fd0 is write-protected, mounting read-only
> # mount -o remount,rw /mnt/floppy
> # echo $?
> 0

Oops. That looks like a bug.

> The bug is present in both 2.4 and 2.6, and is specific to floppy
> devices. Other RO media I tried (CDROM, RO-exported NFS) are partially
> OK, in the sense that a write attempt returns an error; however, "mount
> -o remount,rw" always returns success (this might be a bug in mount).

Interesting. If nobody else gets there first, I'll take a look.

Jon.
