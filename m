Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317066AbSFAVOC>; Sat, 1 Jun 2002 17:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317067AbSFAVOC>; Sat, 1 Jun 2002 17:14:02 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:11526 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S317066AbSFAVOB>;
	Sat, 1 Jun 2002 17:14:01 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200206012113.g51LDur14462@oboe.it.uc3m.es>
Subject: Re: Kernel deadlock using nbd over acenic driver
In-Reply-To: <200205241011.LAA26311@gw.chygwyn.com> from Steven Whitehouse at
 "May 24, 2002 11:11:22 am"
To: Steve Whitehouse <Steve@ChyGwyn.com>
Date: Sat, 1 Jun 2002 23:13:56 +0200 (MET DST)
Cc: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Steven Whitehouse wrote:"

(somethiung about kernel nbd)

BTW, are you maintaining kernel nbd? If so, I'd like to propose
some unifications that would make it possible to run either
enbd or nbd daemons on the same driver, at least in a "compatibility
mode".

The starting point would be

1) make the over-the-wire data formats the same, which means
   enlarging kernel nbd's nbd_request and nbd_reply structs
   to match enbd's, or some compromise.

2) less important .. make the driver structs the same. enbd has more
   fields there too, for accounting purposes. That's the nbd_device struct.

Later on one can add some cross-ioctls.

Peter
