Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTJDNGe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 09:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTJDNGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 09:06:34 -0400
Received: from dirac.phys.uwm.edu ([129.89.57.19]:31906 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S262030AbTJDNGd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 09:06:33 -0400
Date: Sat, 4 Oct 2003 08:06:32 -0500 (CDT)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Re: CMD680, kernel 2.4.21, and heartache (fwd)
Message-ID: <Pine.GSO.4.21.0310040757010.6486-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah, it says 196, and that's bizarre.  196 whats?  From looking at other
> example output, the '1441854' number is usually the true deg. C of the
> machine.  But I'm reasonably sure that it's not at a million and a half
> centigrade.

You need to use a more recent version of smartctl -- one with better
documentation and clearer output.  Get smartmontools 5.1-18 from
http://smartmontools.sourceforge.net/ and read the documentation. Don't
use the 5.19 release -- it's flawed.

This should answer your questions. If not, post the output from (the
smartmontools 5.1-18 version of) smartctl -a and I'll comment.

[Regarding the temperature, the Drive ID string in your output was:
Device: IC35L120AVV207-0 which is an IBM/Hitachi drive, not a Samsung
drive as you stated in your original post.  If so, the drive stores three
temperatures internally in six bytes.  smartmontools will display all
three temperatures (current, lifetime min and lifetime max).  The outdated
version of smartctl that you are using simply prints the bottom four of
the six bytes -- hence the very large number] .

Cheers,
	Bruce


