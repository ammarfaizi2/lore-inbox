Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281504AbRKRWcV>; Sun, 18 Nov 2001 17:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281490AbRKRWcB>; Sun, 18 Nov 2001 17:32:01 -0500
Received: from PSI.MIT.EDU ([18.77.0.154]:13446 "EHLO psi.mit.edu")
	by vger.kernel.org with ESMTP id <S281560AbRKRWbx>;
	Sun, 18 Nov 2001 17:31:53 -0500
Date: Sun, 18 Nov 2001 17:31:57 -0500 (EST)
From: Taylan Akdogan <akdogan@mit.edu>
To: <linux-kernel@vger.kernel.org>
Subject: RTC: max(periodic_freq)>64 for users
In-Reply-To: <Pine.LNX.4.21.0008281517070.6239-100000@psi.mit.edu>
Message-ID: <Pine.LNX.4.33.0111181709420.26843-100000@psi.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Don't you think the maximum periodic_freq of RTC for
un-privileged users is too small for today's computers, which is
only 64Hz? Yes, there may be still 386s out somewhere, but just
because of those we shouldn't suffer. And, I don't believe that
there are multiuser 386 systems which are open to a wide public
in where there may be UNKNOWN evil users. After all, it is
possible to determine the maximum allowed frequency by using CPU
frequency. Ex:

  F < 100 MHz        max=64
  F = [100,500] MHz  max=1024
  F > 500 MHz        max=8192

Or, anything like this which makes sense... It may be very useful
for applications which require better time precision then the
fixed 100 Hz ticks.

Best regards,
Taylan

PS: On 533MHz PIII, 8192Hz is nothing, not even noticeable. On, 
1.5GHz P4 the overhead is zero for all practical purposes. I can 
provide quantitative numbers for these, if needed.

---=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=---
Taylan Akdogan              Massachusetts Institute of Technology
akdogan@mit.edu                             Department of Physics
---=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=---

