Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbTJFJYk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 05:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbTJFJYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 05:24:40 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:60634 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261815AbTJFJYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 05:24:39 -0400
Date: Mon, 6 Oct 2003 11:23:52 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: s390 test6 patches: descriptions.
Message-ID: <20031006092352.GA1786@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
more patches for s390. 7 this time, one is big and another one is VERY big.
Heiko spent an awful lot of time on porting the zfcp scsi host adapter to
2.6. He is finished with it, the rest is bug fixing. The patch is 14000
lines, so I better not sent this to lkml.

Short descriptions:
1) Base fixes for s390.
2) Common i/o layer fixes. One of the things included is the removal of
   the hack in ccwgroup.c which Christoph Hellwig complained about.
3) dasd driver update. We removed the dynamic major allocation code and
   replaced devnos with busids. We definitly like 20 bit minors :-)
4) Kerner janitors complained about verify_area in the ctc driver.
5) iucv patch. The driver core complained about iucv not having a release
   function. Add one.
6) qeth bug fixes and cleanup. Conny removed the read, write and device
   device pointers from the card structure. Unluckily this touches all
   debug statements which produces a rather big patch.

7) The zfcp host adapter.

blue skies,
  Martin.

