Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129381AbRBVBNm>; Wed, 21 Feb 2001 20:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129170AbRBVBNd>; Wed, 21 Feb 2001 20:13:33 -0500
Received: from web12811.mail.yahoo.com ([216.136.174.98]:38929 "HELO
	web12811.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129381AbRBVBNY>; Wed, 21 Feb 2001 20:13:24 -0500
Message-ID: <20010222011322.31071.qmail@web12811.mail.yahoo.com>
Date: Wed, 21 Feb 2001 17:13:22 -0800 (PST)
From: Singh Balbir <basinso@yahoo.com>
Subject: Reliability of serial console driver
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
        I am not on the list, so please reply to me
with the list with your comments.

I was going through some code in serial.c and noticed
that there are page allocations/deallocations in
rs_open and startup (serial.c). These allocations
could fail. This affects reliablity in some minor way

Consider a system running out of memory and the
administrator decided to grab the serial console (say
from home) to see what was wrong.. His open would fail
since we are running out of memory and he would not be
able to use the remote serial console.

I was wondering if it is a good idea to make some such
allocations at boot time. This would mean that these
allocations would never fail. I agree that the chances
of such a scenario occuring is not very high, but it
adds to the reliability of the OS.

What do you think ?

Ba Sin So.

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - Buy the things you want at great prices! http://auctions.yahoo.com/
