Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293084AbSB1AG5>; Wed, 27 Feb 2002 19:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293083AbSB1AGX>; Wed, 27 Feb 2002 19:06:23 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:12548 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S293087AbSB1AF5>; Wed, 27 Feb 2002 19:05:57 -0500
Date: Thu, 28 Feb 2002 01:05:33 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Val Henson <val@nmt.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
        Laurent <laurent@augias.org>, linux-kernel@vger.kernel.org
Subject: Re: read_proc issue
Message-ID: <20020228000532.GA8858@arthur.ubicom.tudelft.nl>
In-Reply-To: <20020227140432.L20918@boardwalk> <E16gBps-0005wa-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16gBps-0005wa-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 09:42:04PM +0000, Alan Cox wrote:
> > I've encountered this problem before, too.  What is the "One True Way"
> > to do this cleanly?  In other words, if you want to do a calculation
> > once every time someone runs "cat /proc/foo", what is the cleanest way
> > to do that?  The solution we came up with was to check the file offset
> > and only do the calculation if offset == 0, which seems pretty
> > hackish.
> 
> Another approach is to do the calculation open and remember it in per
> fd private data. You can recover that and free it on release. It could
> even be a buffer holding the actual "content"

It might also be an idea to export proc_calc_metrics() from
fs/proc/proc_misc.c because quite a lot of code actually tries to do
exactly the same.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
