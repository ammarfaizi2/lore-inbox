Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbRGNMiI>; Sat, 14 Jul 2001 08:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267637AbRGNMh6>; Sat, 14 Jul 2001 08:37:58 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:2063 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S267048AbRGNMho>; Sat, 14 Jul 2001 08:37:44 -0400
Date: 14 Jul 2001 13:37:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: viro@math.psu.edu
cc: linux-kernel@vger.kernel.org
Message-ID: <84pyH-xHw-B@khms.westfalen.de>
In-Reply-To: <Pine.GSO.4.21.0107140151420.19749-100000@weyl.math.psu.edu>
Subject: Re: Question about ext2
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.GSO.4.21.0107140151420.19749-100000@weyl.math.psu.edu>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@math.psu.edu (Alexander Viro)  wrote on 14.07.01 in <Pine.GSO.4.21.0107140151420.19749-100000@weyl.math.psu.edu>:

> On 13 Jul 2001, Kai Henningsen wrote:
>
> > viro@math.psu.edu (Alexander Viro)  wrote on 13.07.01 in
> > <Pine.GSO.4.21.0107130623510.17323-100000@weyl.math.psu.edu>:
> >
> > > The only really obscure part is dropping an extra reference if victim is
> > > a directory - then we know that we are cannibalizing the last external
> > > link to it and the only link that remains is victim's ".". We don't want
> > > it to prevent victim's removal, so we drive i_nlink of victim to zero.
> >
> > Does this stuff work right with those cases which do linkcount=1 either
> > because the fs doesn't have a link count, or because the real link count
> > has grown too large?
>
> It doesn't. If fs doesn't have link count you are very likely to need
> other ways to deal with rename() anyway (e.g. you are pretty likely to
> have part of metadata stored in directory entry). If you are playing
> with "set i_nlink to 1 if it's too large" (which works only for directories,
> BTW) - change according to your encoding scheme for link count.

You are, of course, aware that ext2 (or at least current patches to ext2,  
I'm not sure if this particular thing has gone in yet) does use that  
scheme.

MfG Kai
