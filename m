Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130537AbQLPMLL>; Sat, 16 Dec 2000 07:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130026AbQLPMLC>; Sat, 16 Dec 2000 07:11:02 -0500
Received: from janeway.cistron.net ([195.64.65.23]:9744 "EHLO
	janeway.cistron.net") by vger.kernel.org with ESMTP
	id <S130634AbQLPMKt>; Sat, 16 Dec 2000 07:10:49 -0500
Date: Sat, 16 Dec 2000 12:40:11 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Alexander Viro <viro@math.psu.edu>
Cc: Kurt Garloff <garloff@suse.de>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: TIOCGDEV ioctl
Message-ID: <20001216124011.A14129@cistron.nl>
In-Reply-To: <20001216114645.A8944@cistron.nl> <Pine.GSO.4.21.0012160550240.15518-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0012160550240.15518-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Dec 16, 2000 at 06:15:51AM -0500
X-NCC-RegID: nl.cistron
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Alexander Viro:
> OK, I can see the point of finding out where the console is redirected
> to. How about the following:
> 
> 	/proc/sys/vc -> /dev/tty<n>
> 	/proc/sys/console -> where the hell did we redirect it or
> 			     vc if there's no redirect right now
> Will that be OK with you?

Well, I'd prefer the ioctl, but I can see the general direction the
kernel is heading to: get rid of numeric ioctls and sysctl()s and
put all that info under /proc.

However /proc/sys only contains directories now, it would look
kindof ugly to put 2 symlinks in there directly. Oh well.

Mike.
-- 
RAND USR 16514
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
