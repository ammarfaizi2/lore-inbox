Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWHBGem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWHBGem (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 02:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWHBGel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 02:34:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:35257 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751273AbWHBGel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 02:34:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J0CAJL8BNo/LQevvn9NzEJZPynnphnaoSXsomcY5qCQPHoaBZIuttJ4nd9iArYtkWSwyCJ1JFstpybLcAl4rHApe9w19gnNw/iwTVtUVULoZAgS7xbWpGOvx7zyoqO2m15wkf4ZswIM1RcHoiBQJaeCFMWEEU5BBVLZis9M6MU4=
Message-ID: <aec7e5c30608012334y42e947e6ge935e5d866f78c84@mail.gmail.com>
Date: Wed, 2 Aug 2006 15:34:39 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC] ELF Relocatable x86 and x86_64 bzImages
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Horms <horms@verge.net.au>, "Jan Kratochvil" <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, "Vivek Goyal" <vgoyal@in.ibm.com>,
       "Linda Wang" <lwang@redhat.com>
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The problem:
>
> We can't always run the kernel at 1MB or 2MB, and so people who need
> different addresses must build multiple kernels.  The bzImage format
> can't even represent loading a kernel at other than it's default address.
> With kexec on panic now starting to be used by distros having a kernel
> not running at the default load address is starting to become common.
>
> The goal of this patch series is to build kernels that are relocatable
> at run time, and to extend the bzImage format to make it capable of
> expressing a relocatable kernel.

Nice work. I'd really like to see support for relocatable kernels in
mainline (and kexec-tools!).

Eric, could you please list the advantages of your run-time relocation
code over my incomplete relocate-in-userspace prototype posted to
fastboot a few weeks ago?

One thing I know for sure is that your implementation supports bzImage
while my only supports relocation of vmlinux files. Are there any
other uses for relocatable bzImage except kdump?

Thanks!

/ magnus
