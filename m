Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131663AbRCUR0F>; Wed, 21 Mar 2001 12:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131718AbRCURZ4>; Wed, 21 Mar 2001 12:25:56 -0500
Received: from ip164-145.fli-ykh.psinet.ne.jp ([210.129.164.145]:26819 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S131663AbRCURZp>;
	Wed, 21 Mar 2001 12:25:45 -0500
Message-ID: <3AB8E3E8.F3204180@yk.rim.or.jp>
Date: Thu, 22 Mar 2001 02:24:56 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Interesting post from the MC project to linux-kernel. :block while 
 spinlock held... 
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I suppose that many SCSI maintainers do read the linux-kernel
mailing list. However, just in case, I am quoting one of the
very interesting postings that come from people at Stanford.
They seem to be doing mechanical verification / checking of
linux source code to hunt for potentical bugs. In the last week or so,
many potential bugs were identified and fixed.

Here is one that might be of interest to SCSI developers.
The checkers are known to produce false positives. So beware.

--- begin quote ---
> enclosed are 163 potential bugs in 2.4.1 where blocking functions are
> called with either interrupts disabled or a spin lock held. The
> checker works by:

Here's the file manifest. Apologies.

drivers/atm/idt77105.c
drivers/atm/iphase.c
drivers/atm/uPD98402.c
drivers/block/cciss.c
drivers/block/cpqarray.c
drivers/char/applicom.c
    ...
drivers/scsi/aha1542.c            <--- some scsi files
drivers/scsi/atp870u.c             <----
drivers/scsi/psi240i.c               <----
drivers/scsi/sym53c416.c        <----
drivers/scsi/tmscsim.c              <----
    ...
[the rest omiitted]

--- end quote ---


