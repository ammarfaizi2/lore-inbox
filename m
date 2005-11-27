Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbVK0BqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVK0BqP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 20:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVK0BqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 20:46:15 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:29689 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750812AbVK0BqO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 20:46:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VO1624l7t/AZvs0Gt6sNyiLt0g0O3FEMlJ92eERKGmYlwjckQd2IKezGpq8DmM4vQYHAv58zlCD4EWNZKG4OwM/UEeV9LdSJCSeZvzVL2OrpMCDQVTmaRXuRV/xtUkEbQj17XSiEFO8C65Wi3dyRLHR4zK74ioBK9noj/r7zXoo=
Message-ID: <29495f1d0511261746y12a0c356ueb3d5bb08aa6f6a@mail.gmail.com>
Date: Sat, 26 Nov 2005 17:46:13 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: linux-2.6.14.tar.bz2 permissions
Cc: David Brown <dmlb2000@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200511270138.25769.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com>
	 <200511262346.27907.s0348365@sms.ed.ac.uk>
	 <9c21eeae0511261713vacf13f5u5fdf19711635a381@mail.gmail.com>
	 <200511270138.25769.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/05, Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> On Sunday 27 November 2005 01:13, David Brown wrote:
> > > David, it'd probably help if you listed all of the affected files, then
> > > people can explain themselves and/or correct the permissions.
> > >
> > > I personally think that your point is valid and security should be
> > > considered when packing the kernel sources. It might even be possible for
> > > Linus's tarball script to remove global write permissions.
> >
> > Okay but it's kinda big here's how I did it.
> >
> > # for file in `find *` ; do if ls -l $file | grep -q '^.....w..w.' ;
> > then ls -d $file ; fi ; done | wc -l
> > 19552
> > # find * | wc -l
> > 19552
> >
> > seems to be all of them :\
> >
> > I'll attach the file list
>
> Sure enough, I can confirm this.
>
> I don't seem to have to provide --no-same-permissions to tar to get umask to
> affect the permissions of extracted files, so my files are fine on-disc.

FWIW, ubuntu's man-pages claim:

"       --no-same-permissions
              apply umask to extracted files (the default for non-root users)"

and

"       -p, --same-permissions, --preserve-permissions
              ignore umask when extracting files (the default for root)"

Maybe you are untarring as non-root and David is untarring as root?

> What disturbs me more is the number of people using insecure umasks before
> checking files in! When does a text file really want to be a+w?

That I do not know.

Thanks,
Nish
