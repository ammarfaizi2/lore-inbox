Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262694AbRFLRGc>; Tue, 12 Jun 2001 13:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262702AbRFLRGW>; Tue, 12 Jun 2001 13:06:22 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:14733 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S262694AbRFLRGJ>; Tue, 12 Jun 2001 13:06:09 -0400
From: Ulrich.Weigand@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: Keith Owens <kaos@ocs.com.au>
cc: "David S. Miller" <davem@redhat.com>, DJBARROW@de.ibm.com,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Message-ID: <C1256A69.005DDF6B.00@d12mta11.de.ibm.com>
Date: Tue, 12 Jun 2001 19:05:01 +0200
Subject: Re: bug in /net/core/dev.c
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Keith Owens wrote:

>Minimal (and totally untested) patch to compile s390/net as part of the
>other network drivers follows - if it's good enough for acorn, it's
>good enough for s390.  The method is as ugly as hell but it is the
>least possible change for 2.4, major redesign will have to wait for
>2.5.  Patch against 2.4.6-pre2.

Keith, it's probably much easier to just change arch/s390/Makefile
to link the S/390 drivers *after* all common drivers by moving
drivers/s390/io.o to $DRIVERS instead of $CORE_FILES.

This should fix this particular problem, and appears to be more
logical anyway.

We are just testing this change whether any other problem crop up;
if it's OK we'll send a patch ...



Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com


