Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbVILVHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVILVHR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 17:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVILVHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 17:07:17 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:20562 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932246AbVILVHQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 17:07:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lrtB1q+B1SyD0Te0A0ofKFTvad/en/zotZRwOJo9q2oWQKrH6CRaLsx8nt3k00O53sHkaAJOEM/B2zAKtEfSZ9sVktHguY9tG/qvU1tn5aV6glpBlU+XGsjOOb5KYtgGBxFDNXgsjCHmShdHW3n+E5eGX6YBE0exc/KpG/0QTE4=
Message-ID: <29495f1d05091214077bc49908@mail.gmail.com>
Date: Mon, 12 Sep 2005 14:07:15 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: nish.aravamudan@gmail.com
To: paolo.ciarrocchi@gmail.com
Subject: Re: 2.6.13-mm3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <4d8e3fd3050912140439c14518@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050912024350.60e89eb1.akpm@osdl.org>
	 <4d8e3fd305091208191fbbe804@mail.gmail.com>
	 <29495f1d05091213134d917bd7@mail.gmail.com>
	 <4d8e3fd3050912140439c14518@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/05, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> On 9/12/05, Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
> > On 9/12/05, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> > > On 9/12/05, Andrew Morton <akpm@osdl.org> wrote:
> [...]
> > > >
> > > > - There are several performance tuning patches here which need careful
> > > >  attention and testing.  (Does anyone do performance testing any more?)
> > >
> > > How about the tool announced months ago by Martin J. Bligh ?
> > >
> > > http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html
> >
> > Preferred location is: test.kernel.org (much shorter too!)
> 
> I wasn't aware of that, thank you! Now I won't forget anymore that URL ;-)

That was the idea, I think :)
 
> > Also, the problem for -mm3 is that -mm2 did not build on most
> > machines. -mm1 did on 4/6. Probably some determination could be made
> > from those.
> 
> I see. But I still think that automated testing is a great opportunity
> for the community to pinpoint problems.

Wasn't arguing that point by any means.

> Is there anything we can do to make thinks work better ?

See why the builds failed (the logs should say), e.g. for elm3b6, the
x86-64 box:

arch/x86_64/pci/built-in.o(.init.text+0xa88): In function `pci_acpi_scan_root':
: undefined reference to `pxm_to_node'

and try to fix 'em. Buildable kernels (which has been a problem for
-mm lately, I guess, with certain .configs at least) mean testable
kernels.

Might be fixed in -mm3, I dunno (those jobs haven't been spawned yet,
it would seem).

Thanks,
Nish
