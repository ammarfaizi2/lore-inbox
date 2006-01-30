Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWA3X3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWA3X3D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 18:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWA3X3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 18:29:03 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:14015 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1030208AbWA3X3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 18:29:02 -0500
Message-ID: <43DEA195.1080609@tmr.com>
Date: Mon, 30 Jan 2006 18:30:29 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: CD writing - related question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please take this as a question to elicit information, not an invitation 
for argument.

In Linux currently:
  SCSI - liiks like SCSI
  USB - looks like SCSI
  Firewaire - looks like SCSI
  SATA - looks like SCSI
  Compact flash and similar - looks like SCSI
  ATAPI - looks different unless ide-scsi used

Was there a reason, a technical reason, why the minor blotches in 
ide-scsi weren't fixed so that everything could look the same and share 
the same device naming form? The DMA issue is solved for blocks, and 
several people have stated to the list that the remaining issues could 
be solved in minimal time. Seeing no disagreement, I'll assume that's true.

There are separate IDE drivers for disk, tape, floppy, and CD, and the 
only reason I ever heard was that ide-scsi adds overhead. I did some 
tests using a mighty Pentium-II 350, and there was no overhead with disk 
or CD (within the limits of measurement). So there's no huge CPU 
penalty, why then the decision to have the separate ide drivers?

The last time I tried, there was one thing which didn't work quite right 
doing ZIP drives unless ide-scsi was used, and MO drives don't seem to 
work any other way, but I haven't tried since about 2.6.6 or so, that 
info could be dated.

This is NOT an argument for change, it may be a reminder that ide-scsi 
is not unused, I just never saw any technical reason mentioned.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
