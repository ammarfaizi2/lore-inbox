Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313719AbSDHSEx>; Mon, 8 Apr 2002 14:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313720AbSDHSEw>; Mon, 8 Apr 2002 14:04:52 -0400
Received: from pcp707223pcs.alxndr01.va.comcast.net ([68.49.248.79]:42448 "EHLO
	CJ723460-A") by vger.kernel.org with ESMTP id <S313719AbSDHSEw>;
	Mon, 8 Apr 2002 14:04:52 -0400
Date: Mon, 8 Apr 2002 14:02:33 -0400
From: "G . Sumner Hayes" <sumner-kernel@forceovermass.com>
To: Rene Rebe <rene.rebe@gmx.net>
Cc: rgooch@ras.ucalgary.ca, pavel@suse.cz, bcrl@redhat.com,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: faster boots?
Message-ID: <20020408140233.A19062@forceovermass.com>
In-Reply-To: <200204080057.g380vbO00868@vindaloo.ras.ucalgary.ca> <3CB0EF0B.14D48619@zip.com.au> <20020408130849.A30751@mark.mielke.cc> <20020408.194919.596529874.rene.rebe@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2002 at 07:49:19PM +0200, Rene Rebe wrote:
> On: Mon, 8 Apr 2002 13:08:49 -0400,
>     Mark Mielke <mark@mark.mielke.cc> wrote:
> > Just as 'noatime', or 'sync', perhaps a 'delaywrite' option would be a
> > good choice. An advantage of this approach, is that I could make /tmp
> > be 'delaywrite+journal' in an effort to improve the efficiency of
> > /tmp, as I could care less what I lost in /tmp between reboots under
> > extreme situations.
[SNIP]
> But I also would like such options to make power-saving on Laptops
> easier 

And it's not just for laptop power savings.  People putting together quiet
PCs (for dedicated sound work or just because the PC is in the bedroom)
would like to keep the disks spun down as much as possible, too.

The best I've gotten is ext2(not ext3)+noflushd+noatime+short spindown
time on the drives, plus dead crond and atd and a minimal set of
processes running.  I have a Linux box as a stereo component.

  Sumner
