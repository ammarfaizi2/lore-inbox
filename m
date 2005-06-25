Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263332AbVFYEU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263332AbVFYEU7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 00:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVFYEU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 00:20:59 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:8807 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263332AbVFYEUl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 00:20:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AcvIPT8sLNvmiozUpcUkMkoOOmseg1dTqA5fD6G2hJbgNMQtKMeDKTydHM16euC/zq5LJSs0Z4D4X7RXbsC0J1b2t4lUUUb3OEZN6sddTJPQ7JzU+kkO3Ajpqg2+TB+oZ4M4o/AmxiMQcMDyADpj9WWNCZQh5JWejVboMqmYDFU=
Message-ID: <105c793f05062421207c6ad27@mail.gmail.com>
Date: Sat, 25 Jun 2005 00:20:36 -0400
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Mismatched suspend2 interfaces == Suspend was aborted
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having an odd problem with software-suspend recently. Running the
latest kernel/suspend2/hibernate, I'm getting an error which is
confusing me:

WARNING: The suspend2 scriptlet was written for a different suspend2 interface
         version from the one in your running kernel. This scriptlet was
         written for version between 15 and 15 where as the version running
         in your kernel is 16. Things may not work as expected, but proceeding
         anyway ...

 - hibernate: Suspend reported the following errors:
Suspend was aborted (see dmesg).

"written for a version between 15 and 15" is the part that is
confusing me. First, version 15 of what? Second, between a version and
itself?


So, I look at dmesg. Here's the stuff it says to give when reporting
bugs (plus some extra stuff):

Software Suspend 2.1.9.5: Initiating a software suspend cycle.
Software Suspend 2.1.9.5: Swapwriter: Signature found.
Software Suspend 2.1.9.5: Suspending enabled.
Suspend2: Failed to initialise the compression transform.
Please include the following information in bug reports:
- SUSPEND core   : 2.1.9.5
- Kernel Version : 2.6.12.1
- Compiler vers. : 3.2
- Attempt number : 8
- Pageset sizes  : 3281 (3281 low) and 12192 (12192 low).
- Parameters     : 1 64 0 1 0 5
- Calculations   : Image size: 15676. Ram to suspend: 524.
- Limits         : 49147 pages RAM. Initial boot: 46744.
- Overall expected compression percentage: 0.
- Compressor  enabled.
- Swapwriter active.
  Swap available for image: 48185 pages.
- Filewriter inactive.
- Preemptive kernel.
- Max extents used: 8
- No I/O speed stats available.


I've tried removing /etc/hibernate and /usr/local/sbin/hibernate and
reinstalling hibernate script 1.08, but I still get this error.

I think this might have something to do with the new movement to the
cryptoapi and there's just something I'm not getting.

Anyway, here's my bug report. Thanks.

-Andy
