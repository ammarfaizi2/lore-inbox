Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286491AbRLUAGx>; Thu, 20 Dec 2001 19:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286489AbRLUAGo>; Thu, 20 Dec 2001 19:06:44 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:23722 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S286495AbRLUAGd>; Thu, 20 Dec 2001 19:06:33 -0500
Date: Fri, 21 Dec 2001 00:08:06 +0000
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: andrea@suse.de, davej@codemonkey.org.uk
Subject: Possible O_DIRECT problems ?
Message-ID: <20011221000806.A26849@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>, andrea@suse.de,
	davej@codemonkey.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea, lk,
 I just experimented with O_DIRECT in conjunction with fsx,
and the results aren't pretty.

Over NFS it survives around 921 operations, all local filesystems
(ext2,ext3,reiser tested) just 6 operations.
I've put the source to a modified fsx at
http://www.codemonkey.org.uk/cruft/fsx-odirect.c

It's possible I've done something wrong here, so look it over.
Just adding O_DIRECT flag to open() should be all thats necessary
correct ?

Also note, that by changing the flags on line 988 to have O_DIRECT
also, we get different failure type.

So, did I get the usage of O_DIRECT correct and find some bugs,
or have I had a little too much xmas spirits already ? 8-)


Dave.

-- 
| Dave Jones.                    http://www.codemonkey.org.uk
| SuSE Labs .
