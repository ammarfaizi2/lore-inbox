Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129665AbRBUMUo>; Wed, 21 Feb 2001 07:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130311AbRBUMUe>; Wed, 21 Feb 2001 07:20:34 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:30474 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129665AbRBUMUa>; Wed, 21 Feb 2001 07:20:30 -0500
Date: Wed, 21 Feb 2001 12:48:49 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Thomas Foerster <puckwork@madz.net>
Cc: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
Subject: Re: Shared memory - 2.4.x
Message-ID: <20010221124847.D20058@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010221102311Z129098-513+8693@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010221102311Z129098-513+8693@vger.kernel.org>; from puckwork@madz.net on Wed, Feb 21, 2001 at 11:23:09AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2001 at 11:23:09AM +0100, Thomas Foerster wrote:
> running "top" on a 2.2.18 Kernel showed me the ammount of memory shared.
> 
> Now under 2.4.x "top" always displays "0" and i have mountet the
> tmpfs (if it's needed for that ?).
> 
> Is shared memory gone? Is my "top" to old?! I think i've installed
> all needed versions as described in "Changes" under linux/Documentation
> 
> I don't think there isn't any shared memory, but i'm confused :)

This is becoming a FAQ, could we add it as question 14.3 to the lkml
FAQ?

Yes, the processes stil share memory, but due to changes to the VM in
2.4 it became too CPU intensive to calculate the total amount of shared
memory. In order not to break the userland tools, the "MemShared" field
in /proc/meminfo was set to 0.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
