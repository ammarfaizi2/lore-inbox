Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278063AbRJOTyI>; Mon, 15 Oct 2001 15:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278068AbRJOTx7>; Mon, 15 Oct 2001 15:53:59 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:40694
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S278063AbRJOTxo>; Mon, 15 Oct 2001 15:53:44 -0400
Date: Mon, 15 Oct 2001 12:54:10 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Cyrus <cyrusone@ihug.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large Storage Devices in Linux.....Kernel level support.....
Message-ID: <20011015125410.A22309@mikef-linux.matchmail.com>
Mail-Followup-To: Cyrus <cyrusone@ihug.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.10.10110141947400.18511-100000@orbit-fe.eng.netapp.com> <Pine.GSO.4.10.10110142007130.18511-100000@orbit-fe.eng.netapp.com> <20011014203515.D28547@mikef-linux.matchmail.com> <3BCAA7A2.8070208@ihug.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BCAA7A2.8070208@ihug.com.au>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2001 at 07:08:50PM +1000, Cyrus wrote:
>    hi,
> 
>    thanks for the reply guys. this hdrive is actually quite new i'm wondering
>    what it's doing.. it doesn't warn me anymore of that Smart thing... :-)
>     but, i noticed the longer my system is turned on X just slows down a
>    bit... like moving my mouse to a certain position takes ages. as in, very
>    less responsive.

This could mean that the system is trying to access one drive harder, and
not letting the other respond to requests.  This is even more reason to test
the drive...  While you're at it, test both drives.

>I just got this drives about a week ago the IBM 40GB one.
>    the fujitsu 30GB one is probably just three weeks now. but they're all
>    brand new.... i don't know really, i'm quite confused. i don't know how to
>    prove to that guy in the shop that his drives are faulty.... anyway, so do
>    you think Mike that replacing it would be the only solution?

read-only badblocks will tell you if you have a drive with sectors that are
unreadable.  read-write badblocks will tell you if there are any sectors
that are unwritable.  Be careful, older versions of badblocks will erase all
of your data.  Newer versions have a mode to preserve the data, and still do
a write test, while still keeping the other write mode.  Read the manual page.

>yeah, by the
>    way, i'm using reiserfs how can i check this harddrive for bad blocks i
>    think the program you suggested was for ext2, or was it?
>

Badblocks doesn't care what is on the drive, it just deals with block
devices, that means hard drives, floppy, etc.

I don't know if the new block device in page cache in 2.4.10+ will affect
this, but it looks plausible.  To be sure, use a -ac kernel or 2.4.9 or
older...

>    thanks a lot!
> 
>    cyrus
> 
>    by the way this is my real email address :-) .. i think linuxmail.org
>    closed my account due to inactivity.
> 
>    cheers!

Make sure that you cc the linux-kernel list...

Mike
