Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264361AbRFTAU0>; Tue, 19 Jun 2001 20:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264436AbRFTAUQ>; Tue, 19 Jun 2001 20:20:16 -0400
Received: from harrier.mail.pas.earthlink.net ([207.217.121.12]:31390 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S264361AbRFTAUD>; Tue, 19 Jun 2001 20:20:03 -0400
Message-ID: <3B2FED41.DD8E2B95@earthlink.net>
Date: Tue, 19 Jun 2001 19:24:33 -0500
From: Kelledin Tane <runesong@earthlink.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: How to compile on one machine and install on another?
In-Reply-To: <A5F553757C933442ADE9B31AF50A273B028DB4@corp-p1.gemplex.com> <20010619143253.F81548@onesecure.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Rocha wrote:

> you could always compile on one machine and nfs mount the /usr/src/linux
> and do a make modules_install from the nfs mounted directory...

The way I've always managed this sort of thing is to tar up your kernel source,
transfer it to the "compile box" however you please, then do all the compile
steps except the "make modules_install" and the copying of the kernel image.
Then tar up the compiled source tree, transfer it over to the box you want to
install on, untar it, and do the rest of the steps (the "make modules_install"
and the copying of the kernel image).  Just make sure that all the systems
involved have about the same system time, else you'll get the message, "Clock
skew detected.  Your build may be incomplete."

One day I managed to get egcs-2.91.66 to compile against glibc-2.2, and I never
had to do that stuff again. ;)

Kelledin

bash-2.05 $ kill -9 1
init: Just what do you think you're doing, Dave?

