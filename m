Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293487AbSBZDZB>; Mon, 25 Feb 2002 22:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293495AbSBZDYw>; Mon, 25 Feb 2002 22:24:52 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:41091 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S293487AbSBZDYk>; Mon, 25 Feb 2002 22:24:40 -0500
Date: Mon, 25 Feb 2002 20:24:09 -0700
Message-Id: <200202260324.g1Q3O9I14886@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: me@ohdarn.net (Michael Cohen), linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
Subject: Re: Submissions for 2.4.19-pre [sdmany (Richard Gooch)] [Discuss :) ]
In-Reply-To: <E16fXX8-0007Tn-00@the-village.bc.nu>
In-Reply-To: <20020225204125.72b2289f.me@ohdarn.net>
	<E16fXX8-0007Tn-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > +CONFIG_SD_MANY
> > +  This allows you to support a very large number of SCSI discs
> > +  (approximately 2080). You will also need to set CONFIG_DEVFS_FS=y
> > +  later. This option may consume all unassigned block majors
> 
> As discussed before - this is a bad idea. Please don't regurgitate
> random incorrect patches - it doesnt help. For 2.4 there is no clean
> way to do this for 2.5 driverfs and a 32bit dev_t gets you there for
> free and done right

No, Alan. *You* don't think this is a good idea. Not everyone agrees
with you. My patch is safe: it makes use of the safe major allocation
function so that >128 SD's can be used. You seem to be against this
patch because it would mean that you can't just keep handing out major
numbers, ignoring Linus' "no new majors" decree.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
