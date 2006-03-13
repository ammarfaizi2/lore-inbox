Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWCMLBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWCMLBc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 06:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWCMLBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 06:01:31 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:58192 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750730AbWCMLBb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 06:01:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mIVGaDt0+CO803eMz0zPOYhl4EnCKMSyQM3UZYpEegZw0zs4XTBq3lNBo16lMhmZtOqGzP7ih4wZi445dFuhfqiqGT7+Sz4MYyg7ORg2e18Xcoa4iw8AEFD6EJomQxC/nxmQ91JCCkhBfLqNs/D/KfwIdfr4i8LvNYEREg5PJpg=
Message-ID: <9a8748490603130301l6bc3af75l18155055a8cc20b6@mail.gmail.com>
Date: Mon, 13 Mar 2006 12:01:30 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: swapnil <swapnil@spsoftindia.com>
Subject: Re: Problem applying Patch to linux 2.6 kernel
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060313103946.0C65732C036@smtpauth00.csee.siteprotect.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060313103946.0C65732C036@smtpauth00.csee.siteprotect.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/06, swapnil <swapnil@spsoftindia.com> wrote:
>
> hello,
> I am trying to apply the patch to linux 2.6 kernel on linux fedora core 4.
>
> As per Kernel-HOWTO I should do the following:
> i have downloaded the patch "patch-2.6.15.bz2" from www.linuxhq.com site
> ,kept that patch in /usr/src.
> Changed dir using cd /usr/src and did a
> bzip2 -dc patch-2.6.15.bz2 | patch -p0.
>
> I followed the instructions mentioned, the following happens:
>
> # bzip2 -dc patch-2.6.15 | patch -p0
> can not find file to patch at input line 5 Perhaps you used the wrong -p or

change into the dir holding the actual kernel source - like
~/download/linux-2.6.14/ or wherever you store your kernel source,
then apply the patch with  patch -p1

> --strip option?
> The text leading up to this was:
> --------------------------
> |diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87 index

As you can see from the path, the diff was generated between two dirs
named "a" and "b", since your kernel is not stored in a dir called "b"
-p0 won't work, instead change into the root of the source dir and
tell patch to strip the first dir with -p1.

>
> What steps I am doing wrong while applying the kernel patch?
> Please let me know how can apply the above mentioned patch to mykernel...
> and why I am getting the above mentioned error message...
>
> My current kernel version is 2.6.11-1.1369_FC4 and I am trying to apply
> 2.6.15 kernel patch.
> Is it necessary to apply patches such as 2.6.12,2.6.13,2.6.14 in-order
> before I will have to apply 2.6.15 kernel patch or should I apply 2.6.15
> kernel patch directly without applying intermediate patches?
>
1) the 2.6.15 patch applies to 2.6.14, *not* to 2.6.11, to go from
2.6.11 to 2.6.15 you need to first apply the 2.6.12 patch, then the
2.6.13 patch, then 2.6.14 and finally 2.6.15.

2) don't apply patches for the vanilla kernel to vendor supplied
kernel sources. Vendors, such as RedHat, usually patch the vanilla
kernel with patches of their own, so the vanilla patches will no
longer apply.
Either use vanilla kernels or vendor kernels - don't mix.

>
> Please suggest me to solve this patching problem.
>
It's documented in the kernel source :
http://sosdg.org/~coywolf/lxr/source/Documentation/applying-patches.txt

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
