Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbULYTcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbULYTcb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 14:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbULYTcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 14:32:31 -0500
Received: from mx.inch.com ([216.223.198.27]:61188 "EHLO util.inch.com")
	by vger.kernel.org with ESMTP id S261553AbULYTc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 14:32:27 -0500
Date: Sat, 25 Dec 2004 14:34:00 -0500
From: John McGowan <jmcgowan@inch.com>
To: linux-kernel@vger.kernel.org
Subject: Intel 810(E) driver in Kernel 2.6.10 - same problem as in 2.6.9
Message-ID: <20041225193400.GA2700@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Intel 810(E) driver in Kernel 2.6.10 - same problem as in 2.6.9

Fedora Core2; xorg 6.8.1 (and 6.7.x); kernel 2.6.9/2.6.10
              (other problem in earlier 2.6.x?)
              Intel i810(E) driver

As reported for kernel 2.6.9, since rc1 the intel810(E) support seems to be
broken and the driver does not even work half way, as it did in kernel 2.6.7.

As in 2.6.9, the screen (xorg, 6.8.1; intel 810(E)) comes up with junk
(unable to access the memory?). I did not try disabling (2D) acceleration
this time (as was suggested to a user of Fedora Core3 by the Fedora team as
as reported in one of the usenet groups) since that is much too slow and, as
I recall, did not fix the (apparent) memory leak (which also occurs in 2.6.7).

[memory leak in older 2.6.x kernels]
--
In 2.6.7 it seems memory is not freed either. Gimp-Gap (Gimp 2.0.x or 2.2.x).
Use move-path and move something over an image. OK ... one animation
... do it again (moving another item over the image). And again and again
... It appears that others have no problem(?) with, in kernel 2.6.?, xorg 6.8.1
and 6.7.x, the memory used by move-path being freed. With the intel 810(E) driver
(used by so few, admittedly), it is never freed (using "free" to see it use
up system, buffer and then swap memory). It is not even freed when Gimp is closed
down. One has to close X itself to get the 810(E) driver to free the memory
(unless it is a bug in xorg 6.7.x and 6.8.1). Is this similar to the kernel
2.6.8[.1] bug where the kernel would not free certain memory under certain
conditions (most notably breaking audio CD burning)? Is there a similar bug
in the earlier 2.6.x intel810(E) drivers?

So, I am back to kernel 2.6.7 (Fedora Core2) for some things, rebooting to
RH7.2 with a 2.4.x kernel when I want to get some work done in Gimp.
