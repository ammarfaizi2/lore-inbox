Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbREOV62>; Tue, 15 May 2001 17:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261616AbREOV6T>; Tue, 15 May 2001 17:58:19 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:6412 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261615AbREOV6A>; Tue, 15 May 2001 17:58:00 -0400
Message-ID: <3B01A649.A51E54DE@transmeta.com>
Date: Tue, 15 May 2001 14:57:29 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Chip Salzenberg <chip@valinux.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.GSO.4.21.0105151746320.22958-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Tue, 15 May 2001, Chip Salzenberg wrote:
> 
> > According to Linus Torvalds:
> > > I don't see why we couldn't expose the "driver name" for any file
> > > descriptor.
> >
> > Is it wise to assume that there is only one such name for *any* file
> > descriptor?
> 
> Type of filesystem where the file came from? Sure.
> 

I think this is the wrong question.  A device can inherently belong to
multiple device classes, and it really should be thought of as such.  For
example a disk may belong, at the same time, to the "scsi", "disk" and
"scsi-disk" device classes, meaning that it supports the union of the
"scsi" common interfaces, "disk" common interfaces, and "scsi-disk"
common interfaces.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
