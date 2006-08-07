Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWHGQL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWHGQL1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWHGQL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:11:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:20813 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932198AbWHGQLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:11:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mV1wX1fn6h96hjws0SSxy/V5adkcEeRAbmpgyCcQLqeGqNhWOTOEGKkRZ9WQEZrtG+YHaRblwhtgcV8EESgChQ3gIMvnRJpFvuddJsvhkZbOWXm1wb3+YVhZHYVFCqXfzacKYCp4/FkSIQ734iuP4SjyEqf19ToMLSwtj7nlwWI=
Message-ID: <292693080608070911g57ae1215qd994e03b9dd87b66@mail.gmail.com>
Date: Mon, 7 Aug 2006 21:41:23 +0530
From: "Daniel Rodrick" <daniel.rodrick@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Univeral Protocol Driver (using UNDI) in Linux
Cc: "Linux Newbie" <linux-newbie@vger.kernel.org>,
       kernelnewbies <kernelnewbies@nl.linux.org>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <44D7579D.1040303@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <292693080608070339p6b42feacw9d8f27a147cf1771@mail.gmail.com>
	 <44D7579D.1040303@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/06, H. Peter Anvin <hpa@zytor.com> wrote:
> Daniel Rodrick wrote:
> > Hi list,
> >
> > I was curious as to why a Universal driver (using UNDI API) for Linux
> > does not exist (or does it)?
> >
> > I want to try and write a such a driver that could (in principle)
> > handle all the NICs that are PXE compatible.
> >
> > Has this been tried? What are the technical problems that might come in
> > my way?
> >
>
> It has been tried; in fact Intel did implement this in their "Linux PXE
> SDK".  The UNDI API is absolutely atrocious, however, being based on
> NDIS2 which is widely considered the worst of all the many network
> stacks for DOS.
>
> Additionally, many UNDI stacks don't work correctly when called from
> protected mode, since the interface doesn't work right.  Additionally,
> UNDI is *ONLY* available after booting from the NIC.
>

Agreed. But still having a single driver for all the NICs would be
simply GREAT for my setup, in which all the PCs will be booted using
PXE only. So apart from performance / relilability issues, what are
the technical roadblocks in this?

I'm sure having a single driver for all the NICs is a feature cool
enough to die for. Yes, it might have drawbacks like just pointed out
by Peter, but surely a "single driver for all NIC" feature could prove
to be great in some systems.

But since it does not already exist in the kernel, there must be some
technical feasibility isse. Any ideas on this?

And any Idea where can I find the Intel's PXE SDK for Linux? I googled
for an hour but to no avail. Texts suggest that it was available on
Intel Architecture's Lab website which is non existent now. I would
appreciate if some one could send me the PXE SDk from Intel, if
somebody still has a copy.

Thanks,

Dan
