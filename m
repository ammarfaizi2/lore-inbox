Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135248AbREHUGr>; Tue, 8 May 2001 16:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135242AbREHUGh>; Tue, 8 May 2001 16:06:37 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:39720 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S135239AbREHUGT>; Tue, 8 May 2001 16:06:19 -0400
Message-ID: <3AF85143.D78886BD@sgi.com>
Date: Tue, 08 May 2001 13:04:19 -0700
From: LA Walsh <law@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [i386 arch] MTR messages significant?]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been seeing these for a while now (2.4.4 - <=2.4.2) also coincidental
with a change to XFree86 X 4.0.3 from "MetroX" in the time frame.  Am not sure
exactly when they started but was wondering if they were significant.  It
seems some app is trying to delete or modify something.  On console and in syslog:

mtrr: no MTRR for fd000000,800000 found
mtrr: MTRR 1 not used
mtrr: reg 1 not used

while /proc/mtrr currently contains:

reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0xfd000000 (4048MB), size=   8MB: write-combining, count=1

Could it be the X server trying to delete a segment when it it starts up or
shuts down?  Is it an error in the X server to try to delete a non-existant
segment?  Does the kernel 'care'?  I.e. -- why is it printing out messages --
are they debug messages that perhaps should be off by default?

Concurrent with these messages and perhaps unrelated is a new, unwelcome,
behavior of X dying on display of some Netscape-rendered websites (cf. it
doesn't die under konqueror).

thanks,
-linda
