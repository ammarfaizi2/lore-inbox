Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287303AbSAWWht>; Wed, 23 Jan 2002 17:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289330AbSAWWhl>; Wed, 23 Jan 2002 17:37:41 -0500
Received: from web11201.mail.yahoo.com ([216.136.131.171]:36439 "HELO
	web11201.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S287303AbSAWWhg>; Wed, 23 Jan 2002 17:37:36 -0500
Message-ID: <20020123223734.44281.qmail@web11201.mail.yahoo.com>
Date: Wed, 23 Jan 2002 14:37:34 -0800 (PST)
From: gravsten <gravsten@yahoo.com>
Subject: cannot disable INET from (arm-)linux-2.4.17
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I was advised to re-post this to your mailing list, instead of       
linux-arm-kernel@lists.arm.linux.org.uk - hopefully this is the right place.

I just completed a build of 2.4.17 patched for ARM (SA11x0), and ran across
this problem: if I disable TCP/IP (INET), some stuff in Networking (NET) fails.
This comes from the reference in net/core/rtnetlink.c to tcp.h, which calls
ecn_tcp.h, and further addresses 'af_inet' in the sock structure, although it
is not defined. As a result, I had to get INET back into my .config , which of
course is an annoyance. Does any of you have experienced this already? Is there
a fix?

Besides, I would very much like your comments on running the SA11x0 with or
without MMU. What other patch(es) are you using on this platform?

Please respond to me personally (in Cc: at least), as I am not (yet) registered
to this mailing list.

Thanks,
Guilhem.


__________________________________________________
Do You Yahoo!?
Send FREE video emails in Yahoo! Mail!
http://promo.yahoo.com/videomail/
