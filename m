Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267541AbRGMVGJ>; Fri, 13 Jul 2001 17:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267540AbRGMVF7>; Fri, 13 Jul 2001 17:05:59 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:45318 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S267539AbRGMVFk>; Fri, 13 Jul 2001 17:05:40 -0400
Date: 13 Jul 2001 22:22:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: viro@math.psu.edu
cc: linux-kernel@vger.kernel.org
Message-ID: <84l4sXb1w-B@khms.westfalen.de>
In-Reply-To: <Pine.GSO.4.21.0107130623510.17323-100000@weyl.math.psu.edu>
Subject: Re: Question about ext2
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.GSO.4.21.0107130623510.17323-100000@weyl.math.psu.edu>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@math.psu.edu (Alexander Viro)  wrote on 13.07.01 in <Pine.GSO.4.21.0107130623510.17323-100000@weyl.math.psu.edu>:

> The only really obscure part is dropping an extra reference if victim is
> a directory - then we know that we are cannibalizing the last external
> link to it and the only link that remains is victim's ".". We don't want
> it to prevent victim's removal, so we drive i_nlink of victim to zero.

Does this stuff work right with those cases which do linkcount=1 either  
because the fs doesn't have a link count, or because the real link count  
has grown too large?

MfG Kai
