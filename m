Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUJ1JI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUJ1JI5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 05:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbUJ1JI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 05:08:56 -0400
Received: from colino.net ([213.41.131.56]:17905 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262837AbUJ1JIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 05:08:54 -0400
Date: Thu, 28 Oct 2004 11:07:31 +0200
From: Colin Leroy <colin@colino.net>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sf.net
Subject: Re: [linux-usb-devel] 2.6.10-rc1 OHCI usb error messages
Message-ID: <20041028110731.74ac5eb5.colin@colino.net>
In-Reply-To: <200410271559.37540.david-b@pacbell.net>
References: <20041026172843.6ac07c1a.colin@colino.net>
	<200410260905.14869.david-b@pacbell.net>
	<20041027110756.3217ed68.colin@colino.net>
	<200410271559.37540.david-b@pacbell.net>
X-Mailer: Sylpheed-Claws 0.9.12cvs132.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Oct 2004 at 15h10, David Brownell wrote:

Hi, 

> You're not reporting that it fails to activate when there's an
> active device connected; and you obviously enabled CONFIG_PM,
> which Kconfig says means that
> 
> 	... parts of your computer are shut off or put into a
> 	power conserving "sleep" mode if they are not being used.
> 
> So:  since it's not being actively used then, why shouldn't the
> root hub (or any other device) be suspended?  During boot, or at
> any other time.  So long as it works when you plug in a USB device,
> it looks to me like everything is behaving quite reasonably.

That's right. Just that it didn't do so previously, so i didn't think 
of that.

> > At least, it's not on 2.6.9. Also, 
> > lsusb -v fails with long timeouts due to that on 2.6.10-rc1, 
> > not on 2.6.9.
> 
> I've never observed "lsusb" ever timing out when accessing a
> suspended USB device; the URB submissions fail right away.

Strange. Something else maybe...

> So if something's timing out, it's for some other reason.
> (Such as bugs in "lsusb"; the "usbutils" package is overdue
> for a new release, it's changed a lot since the 0.11 tarball
> that's widely available.)

Yes, btw, I once sent a patch about lsusb endianness problems, and didn't
hear anything back about it. I ended up sending the patch to the gentoo
guys so that at least my distro is fixed:

http://bugs.gentoo.org/show_bug.cgi?id=43565
-- 
Colin
