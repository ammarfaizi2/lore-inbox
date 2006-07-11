Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWGKNJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWGKNJE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 09:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWGKNJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 09:09:04 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:47396 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750960AbWGKNJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 09:09:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kOfE9H27inLeEd/+/pe77/B/1nGpgfrs0VFM2/vku+5MSfLmZX+4AKaNKySKGoEUYrwOp/pqKSLlOZMc9PIFh0v6igOaPJpjskUtUcn+2Rqgp3hiLVSAO9A8YKhvKCuT6+4v9bBdpepVzjNgRuvq4HcRVSYCWCgTSGGiM4bxLZI=
Message-ID: <6bffcb0e0607110609s33456805y8713cd201005b017@mail.gmail.com>
Date: Tue, 11 Jul 2006 15:09:01 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0607110600q345b5ad7y38174b85cf01edba@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <6bffcb0e0607110527x4520d5bbne8b9b3639a821a18@mail.gmail.com>
	 <6bffcb0e0607110546r11d2f619pbcd1205999253bd@mail.gmail.com>
	 <6bffcb0e0607110551v272deebcua5dc3f782ed25a7f@mail.gmail.com>
	 <b0943d9e0607110600q345b5ad7y38174b85cf01edba@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 11/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > On 11/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > > When I set DEBUG_KEEP_INIT=n everything works fine.
> >
> > I was wrong.
>
> You mean the previous e-mail wasn't a kmemleak bug?

It is kmemleak bug. I wrote "I was wrog" concerning "everything works fine" :)

>
> > Here is the new error
> > /usr/src/linux-work4/kernel/pid.c: In function 'pid_task':
> > /usr/src/linux-work4/kernel/pid.c:262: error: initializer element is
> > not constant
> > /usr/src/linux-work4/kernel/pid.c:262: error: (near initialization for
> > '__memleak_offset__container_of.offset')
> > make[2]: *** [kernel/pid.o] Error 1
> > make[1]: *** [kernel] Error 2
> > make: *** [_all] Error 2
>
> That's a bug in gcc-4.

Yes of course. I forgot about this.

> The __builtin_constant_p() function always
> returns true even when the argument is not a constant. You could try a
> gcc-3.4 or a patched gcc.
>
> --
> Catalin
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
