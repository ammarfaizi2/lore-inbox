Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135902AbREDIKN>; Fri, 4 May 2001 04:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135912AbREDIKE>; Fri, 4 May 2001 04:10:04 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:5124 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S135902AbREDIJy>;
	Fri, 4 May 2001 04:09:54 -0400
Message-ID: <20010503235923.A11836@bug.ucw.cz>
Date: Thu, 3 May 2001 23:59:23 +0200
From: Pavel Machek <pavel@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>,
        "H. Peter Anvin" <hpa@transmeta.com>
Cc: Brouwer <Andries.Brouwer@cwi.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: iso9660 endianness cleanup patch
In-Reply-To: <3AEE4A06.3666F4BE@transmeta.com> <3AEFCAD0.BE2A5FA@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3AEFCAD0.BE2A5FA@evision-ventures.com>; from Martin Dalecki on Wed, May 02, 2001 at 10:52:32AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I was looking over the iso9660 code, and noticed that it was doing
> > endianness conversion via ad hoc *functions*, not even inlines; nor did
> > it take any advantage of the fact that iso9660 is bi-endian (has "all"
> > data in both bigendian and littleendian format.)
> > 
> > The attached patch fixes both.  It is against 2.4.4, but from the looks
> > of it it should patch against -ac as well.
> 
> Please beware: There is a can of worms you are openning up here, 
> since there are many broken CD producer programms out there, which
> only provide the little endian data and incorrect big endian
> entries. I had some CD's of this form myself. So the endian neutrality
> of the iso9660 is only in the theory present...

Hmm, perhaps there's time to fsck.iso9660?
								Pavel
PS: It might be funny to *deliberately* create different filesystems;
one on little endian side and one on big endian side. That way windows
users would see "macs suck" and mac users "PCs suck", and that with
just one cd ;-).
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
