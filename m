Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129118AbRBOTtc>; Thu, 15 Feb 2001 14:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129224AbRBOTtX>; Thu, 15 Feb 2001 14:49:23 -0500
Received: from ellpspace.math.ualberta.ca ([129.128.207.67]:21831 "EHLO
	ellpspace.math.ualberta.ca") by vger.kernel.org with ESMTP
	id <S129118AbRBOTtI>; Thu, 15 Feb 2001 14:49:08 -0500
Date: Thu, 15 Feb 2001 12:48:37 -0700
From: Michal Jaegermann <michal@ellpspace.math.ualberta.ca>
To: John Jasen <jjasen@datafoundation.com>
Cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org,
        axp-list@redhat.com, denis@datafoundation.com
Subject: Re: 2.4.x/alpha/ALI chipset/IDE problems summary Re: 2.4.1 not fully sane on Alpha - file systems
Message-ID: <20010215124837.B13755@ellpspace.math.ualberta.ca>
In-Reply-To: <Pine.LNX.4.10.10102011415070.17898-100000@master.linux-ide.org> <Pine.LNX.4.30.0102151247410.4654-100000@flash.datafoundation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <Pine.LNX.4.30.0102151247410.4654-100000@flash.datafoundation.com>; from John Jasen on Thu, Feb 15, 2001 at 12:49:29PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2001 at 12:49:29PM -0500, John Jasen wrote:
> 
> Well, the situation is improving, I suppose ...
> 
> Under kernel 2.4.0 and 2.4.1, a dd of about 10000 4k blocks would cause
> the system to go technicolor and lock up.

On UP1100 which I have here somehow this looks a bit different _after_
I put on it the latest SRM and used this "magic incantation" from
Hyung Min SEO ('d -l 801fe0000ac d' at SRM prompt to modify firmware).
I copied from disk to disk directory tries with some 150 MB of data
in these and no ill effects.

OTOH things are still wobbly.  This shows up in this that trying to
run e2fsck on a dirty file system while booting one 2.4.1 is likely
to come up with all kind of errors in a file sytstem requiring manual
interactions.  If one breaks this process and repeats an exercise
on the same file system, but booting this time 2.2.18, then things
check out without any incidents.  Once clean file systems can be
used with 2.4.1 again and no problems are reported.

I really do not see any kernel problems with 2.2 series kernels and IDE
patches.

> Now, under 2.4.1-ac13, at about 11000 blocks, it goes technicolor, but
> doesn't lock up until somewhere between 13000 and 20000.

I got various lockups but no "technicolor" on any occasion.  Recently
I even got a picture with X and G450 Matrox card although one can
be very careful not to look at it a wrong angle or a power button will
be the only way out.

  Michal
