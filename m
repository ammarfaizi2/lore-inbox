Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWBFHio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWBFHio (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 02:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWBFHio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 02:38:44 -0500
Received: from uproxy.gmail.com ([66.249.92.195]:13807 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750711AbWBFHin convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 02:38:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HzR9dDqTlqo/yaRm/hWDIcHJdfJs573luNgoeizHLPIZ41vk7HqfT37PYj2MZIlPaG7Ze4/pqIRdHmiRwx2jhoSKBSF6VXCJWh5tZ5NcZ6N6qNV/qYteUju92wn44vzyFJjER4xFbTApe/7Xsy9cppWu5LMESxIU3Ox8BWfT6j0=
Message-ID: <9e0cf0bf0602052338p127918f4l1f50b9583ce8d31@mail.gmail.com>
Date: Mon, 6 Feb 2006 09:38:40 +0200
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit - Resubmit
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060205201844.447efd20.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43E3BDDD.6000402@gmail.com>
	 <20060205201844.447efd20.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Since I removed this from the main text:

>-The kernel command line is a null-terminated string currently up to
>-255 characters long, plus the final null.  A string that is too long
>-will be automatically truncated by the kernel, a boot loader may allow
>-a longer command line to be passed to permit future kernels to extend
>-this limit.
>+The kernel command line is a null-terminated string. A string that is too
>+long will be automatically truncated by the kernel.

I thought it would be appropriate to add it to the older (<2.02) boot
protocols specific notes.

>+       The kernel command line *must* be 256 bytes including the
>+       final null.

I've removed the 256 limit from the 2.02 boot protocol since grub and
lilo guys did not understand the comment: "a boot loader may allow a
longer command line to be passed to permit future kernels to extend
this limit.", they both truncate the command-line to 256 (hard coded).
I thought that it best to make clear that the limit on the
command-line length is determined by the kernel and not by the boot
loader.

I can remove the addition.

Best Regards,
Alon Bar-Lev

On 2/6/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> On Fri, 03 Feb 2006 22:32:29 +0200 Alon Bar-Lev wrote:
>
> >
> > Extending the kernel parameters to a size of 1024 on boot
> > protocol >=2.02 for i386 and x86_64 architectures.
> >
> > Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>
> >
> > ---
> >
> > Hello,
> >
> > This patch was submitted a long ago, but did not find its
> > way into the kernel, but was not rejected as well.
> >
> > Current implementation allows the kernel to receive up to
> > 255 characters from the bootloader.
> >
> > In current environment, the command-line is used in order to
> > specify many values, including suspend/resume, module
> > arguments, splash, initramfs and more.
> >
> > 255 characters are not enough anymore.
> >
> > Please consider to merge.
>
> Please explain this comment and why it is being added:
>
> +       The kernel command line *must* be 256 bytes including the
> +       final null.
> +
>
> thanks,
> ---
> ~Randy
>
