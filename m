Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266058AbRGGICX>; Sat, 7 Jul 2001 04:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266063AbRGGICO>; Sat, 7 Jul 2001 04:02:14 -0400
Received: from mackman.submm.caltech.edu ([131.215.85.46]:46466 "EHLO
	mackman.net") by vger.kernel.org with ESMTP id <S266058AbRGGICC>;
	Sat, 7 Jul 2001 04:02:02 -0400
Date: Sat, 7 Jul 2001 01:02:01 -0700 (PDT)
From: Ryan Mack <rmack@mackman.net>
To: <max_mk@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [BUG?] vtund broken by tun driver changes in 2.4.6
Message-ID: <Pine.LNX.4.33.0107070058350.29490-100000@mackman.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently upgraded a server running vtund 2.4 (4/18/01) to stock 2.4.6
kernel.  It seems the changes to the tun driver have broken vtund.  Now my
syslog gets filled with the following messages when a client attempts to
connect:

Jul  5 10:15:53 mackman vtund[4011]: Session
mackman-vpn[64.169.117.25:2359] opened
Jul  5 10:15:53 mackman vtund[4011]: Can't allocate tun device. File
descriptor in bad state(77)
Jul  5 10:15:53 mackman vtund[4011]: Session mackman-vpn closed
Jul  5 10:16:04 mackman vtund[4014]: Session
mackman-vpn[64.169.117.25:2360] opened
Jul  5 10:16:04 mackman vtund[4014]: Can't allocate tun device. File
descriptor in bad state(77)
Jul  5 10:16:04 mackman vtund[4014]: Session mackman-vpn closed

Eventually the client gives up.  Do you have any suggestions or know of
any fixes?

Thanks, Ryan Mack

