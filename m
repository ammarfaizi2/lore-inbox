Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264134AbRFFUJi>; Wed, 6 Jun 2001 16:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264135AbRFFUJ2>; Wed, 6 Jun 2001 16:09:28 -0400
Received: from colorfullife.com ([216.156.138.34]:45316 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S264134AbRFFUJX>;
	Wed, 6 Jun 2001 16:09:23 -0400
Message-ID: <3B1E8DCC.442431CA@colorfullife.com>
Date: Wed, 06 Jun 2001 22:08:44 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>,
        linux-kernel@vger.kernel.org,
        "David Gordon (LMC)" <David.Gordon@ericsson.ca>
Subject: RE: kHTTPd hangs 2.4.5 boot when moduled
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 	
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> 
> package RH7.0 has...    2.4.2 and on needs...
> util-linux      2.10m           2.10o
> modutils        2.3.21          2.4.2
> e2fsprogs       1.18            1.19

Which compiler do you use? The default compiler from 7.0 is known to
produce buggy kernels, and Linus didn't include the kgcc detection.

Could you check that kgcc is used for compiling?
Just replace '$(CROSS_COMPILE)gcc' in /usr/src/linux/Makefile with
'$(CROSS_COMPILE)kgcc'

Or upgrade to the gcc compiler from 7.1?

--
	Manfred
