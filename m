Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289646AbSA2RtI>; Tue, 29 Jan 2002 12:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289789AbSA2Rs6>; Tue, 29 Jan 2002 12:48:58 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:56477 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S289646AbSA2Rsq>; Tue, 29 Jan 2002 12:48:46 -0500
Date: Tue, 29 Jan 2002 10:48:21 -0700
Message-Id: <200201291748.g0THmLS23684@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KERN_INFO for devfs
In-Reply-To: <200201291140.g0TBecE28017@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <000701c1a8b1$2f493850$21c9ca95@mow.siemens.ru>
	<200201291140.g0TBecE28017@Port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko writes:
> > > Why do you think they _have to_ have "none"? Is it POSIXized or
> > > otherwise standardized? Where can I RTFM?
> >
> > I do not think they have to. They just are :-)
> >
> > fs/namespace.c:show_vfsmnt()
> >
> > ...
> > mangle(m, mnt->mnt_devname ? mnt->mnt_devname : "none");
> >
> >
> > I find this convention quite useful. It allows any program to easily
> > skip virtual filesystems. Using something like /dev or devfs in this
> > case does not add any bit of useful information but possibly adds to
> > confusion.
> 
> Maybe you're right. It's up to maintainer to decide.
> Richard, do you need updated patch without "none" -> "devfs"?

Don't bother. I've gone through the code and done it myself, making
some other minor changes as I go along.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
