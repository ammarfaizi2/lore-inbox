Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271792AbRICUFT>; Mon, 3 Sep 2001 16:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271793AbRICUFK>; Mon, 3 Sep 2001 16:05:10 -0400
Received: from alpha.netvision.net.il ([194.90.1.13]:43780 "EHLO
	alpha.netvision.net.il") by vger.kernel.org with ESMTP
	id <S271792AbRICUFC>; Mon, 3 Sep 2001 16:05:02 -0400
Message-ID: <3B93E289.7F121DE9@netvision.net.il>
Date: Mon, 03 Sep 2001 23:05:29 +0300
From: Michael Ben-Gershon <mybg@netvision.net.il>
Organization: My Office
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en-GB, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: lpr to HP laserjet stalls
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 'lpr' to print to an HPLaserJet 6P printer often hangs midway.
This may happen both when the printer is used in its 'raw' mode and
as a filter through ghostscript. It is apparent both when printing
locally, and using Samba over the network. My own research seems
to have narrowed the problem down to the kernel. kernel 2.2.x (up to
2.2.19) was fine. I have had the problem with all 2.4.x kernels,
from 2.4.6 to 2.4.9.

I initially thought it was the new lpd supplied with RedHat linux 7.1,
but although I initially thought that reverting to the old lpd had
cured the problem, I now find it happening all the time.

It is intermittent, but very frequent. It is difficult to print more
than about 10 sheets without it happening sometime.

I have serached everywhere but not found any reports of such a problem,
except for one other user who also mailed the RedHat bugzilla list as
follows:

+------- Additional comments from lgt@dmu.ac.uk 2001-08-09 11:59:12 -------
I have exactly this same problem with my HP LaserJet 1100 - random stalls in
multi-page print jobs. The printer stops with the light on that normally
indicates data is left in the buffer that hasn't been printed yet. The print
queue eventually says it's stalled. Pressing the printer button to force out
the
page gives a page of truncated output, then a second page with what looks like
some printer commands on it, starting with "@PJL SET RET=MEDIUM". After
printing
this duff page, the printer is idle but the print queue is still stalled.
Re-starting lpd simply re-prints the same file again, starting from the
beginning, which then fails at some other random point in the file.

I had no trouble whatsoever with RedHat 6.2 or 7.0 and this printer. Now,
however, I can't reliably print anything other than a single page file - and
even that fails sometimes if other files are in the queue.

+--------------------------------------------------------------------------

It seems that his problem is similar, but maybe not exactly the same as mine,
but looks as if is caused by the same fault.

Any ideas?

Michael Ben-Gershon
mybg@netvision.net.il
