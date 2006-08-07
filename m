Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWHGMQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWHGMQH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 08:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWHGMQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 08:16:07 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:45111 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932091AbWHGMQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 08:16:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aXRJTsWpmOIYd5TFyEtKGq4vsUmkBlHv2C3A1DT6X3DgE2AxvaEUYGWG1SffP5Z8yN+okOycEMVfIuKUWnMJWZ/RJqQvtUaNPL0rrfYh/WRiv7Fyl0NS2XqWGlMcNqE2unANQAUpsPx4pwA0KD+oE0y62/HJa+0U6C4TT7jrxEY=
Message-ID: <6bffcb0e0608070516o6f750db8h31ffbfe63db9f8c9@mail.gmail.com>
Date: Mon, 7 Aug 2006 14:16:04 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: balbir@in.ibm.com
Subject: Re: 2.6.18-rc3-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, "Jay Lan" <jlan@sgi.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <44D70D79.1010106@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	 <6bffcb0e0608060409m2cd8fb4er6d7d2300915604c4@mail.gmail.com>
	 <44D70D79.1010106@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/08/06, Balbir Singh <balbir@in.ibm.com> wrote:
> Michal Piotrowski wrote:
> > Hi,
> >
> > On 06/08/06, Andrew Morton <akpm@osdl.org> wrote:
> >>
> >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
> >>
> >>
> >
> > I get this error during the build.
> >
> > kernel/built-in.o: In function `bacct_add_tsk':
> > /usr/src/linux-mm/kernel/tsacct.c:39: undefined reference to `__divdi3'
> > make[1]: *** [.tmp_vmlinux1] Error 1
> > make: *** [_all] Error 2
> >
> > I'll try with CONFIG_TASKSTATS disabled.
> >
> > Regards,
> > Michal
> >
>
> Sounds likes we are trying to do a 64 bit division since timespec_to_ns()
> returns a 64 bit value.
>
> Here's a compile tested patch to fix the problem
>

It doesn't apply
cat patches/tsacct1.patch | patch -p1 --dry-run
patching file kernel/tsacct.c
Hunk #1 FAILED at 36.
1 out of 1 hunk FAILED -- saving rejects to file kernel/tsacct.c.rej

Andrew's csa-basic-accounting-over-taskstats-fix.patch fix compilation problem.

> --
>         Regards,
>         Balbir Singh,
>         Linux Technology Center,
>         IBM Software Labs
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
