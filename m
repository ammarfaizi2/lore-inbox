Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130396AbRCBKhz>; Fri, 2 Mar 2001 05:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130397AbRCBKhq>; Fri, 2 Mar 2001 05:37:46 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:59910 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S130396AbRCBKhm>; Fri, 2 Mar 2001 05:37:42 -0500
Date: Fri, 2 Mar 2001 11:35:31 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Pavel Machek <pavel@suse.cz>
Cc: "Mike A. Harris" <mharris@opensourceadvocate.org>,
        Tim Wright <timw@splhi.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Wrong data [was Re: Incorrect module init message..]
Message-ID: <20010302113531.E25658@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010222100132.A1744@kochanski.internal.splhi.com> <Pine.LNX.4.33.0102221325530.2548-100000@asdf.capslock.lan> <20000101014940.C28@(none)>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20000101014940.C28@(none)>; from pavel@suse.cz on Sat, Jan 01, 2000 at 01:49:41AM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 01, 2000 at 01:49:41AM +0000, Pavel Machek wrote:
> > No, Pavel's clock is fine AFAIK.  The message was sent in
> > January.  However, it was just received AGAIN today.  I don't
> 
> Unfortunately, my clock is b0rken. This damn little machine just does
> not have ability to retain time across reboot. [For booting, I need
> winCE. WinCE will crash upon boot if something unexpected (like linux)
> is in memory. Therefore I need to remove main battery for reboot :-(.]
> 
> It even does not have ability to retain time correctly during powersave
> mode, but that could be solved.
> 
> Before someone says "NTP", this machine is usually not connected anywhere --
> it comunicates via ATA flash. Maybe I could scan  flash for newest timestamp
> and use that for date...

On a similar system I use a little trick so the time is at least always
increasing:

- touch the file /etc/timestamp just before the system shuts down
- on bootup I set the time with:
    CURRENTTIME=date -r /etc/timestamp
    date -s "$CURRENTTIME"


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
