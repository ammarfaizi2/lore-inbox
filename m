Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263582AbTDNRp2 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 13:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbTDNRp2 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 13:45:28 -0400
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:20716 "EHLO
	d12lmsgate-5.de.ibm.com") by vger.kernel.org with ESMTP
	id S263582AbTDNRp1 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:45:27 -0400
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390: descriptions.
Date: Mon, 14 Apr 2003 19:45:33 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304141945.33929.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
the s390 patch set keeps growing: 16 patches against bitkeeper of 2003/04/14.
This patch set includes a nice one: the removal (!!) of the s390x architecture
files. I hope this makes Christoph Hellwig happy who has been nagging us to
do so. In fact it was easier than I thought it would be. Arnd did some
Makefile magic that allowed us to remove one file after the other. This sped
up the process quite a bit.

Short descriptions:
1) s390 architecture changes and bug fixes. There is one fix that affects
   common code: invoke_softirq. For s390 we want to switch to the async.
   interrupt stack in local_bh_enable.
2) Add support for system call numbers > 255.
3) Common i/o layer changes.
4) Bug fixes for the sclp and 3215 console drivers.
5) Bug fixes for the ctc, lcs and iucv network drivers.
6) Make uni-processor kernels compile & work again.
7) Bug fixes & small improvements for the dasd driver. 
8) Coding style adaptions for the dasd driver. This patch is big but it
   doesn't do much. I removed outdated comments and most of the structure
   typedefs. No real code change in this one.
9) Part 2 of the dasd coding style adaptions.
10-16) The patches 10-16 belong together. They merge the s390x architecture
   bits into the s390 files. 31/64 bit is now a configuration option.
   The effect of this is that the files in include/asm-s390x and arch/s390x
   can be removed. If you apply the patches 10-16 please do so. I didn't
   want to send another huge patch just to remove the two directories.

blue skies,
  Martin.


