Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290349AbSAPEGZ>; Tue, 15 Jan 2002 23:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290346AbSAPEGP>; Tue, 15 Jan 2002 23:06:15 -0500
Received: from mercury.mv.net ([199.125.85.40]:16604 "EHLO mercury.mv.net")
	by vger.kernel.org with ESMTP id <S290347AbSAPEGH>;
	Tue, 15 Jan 2002 23:06:07 -0500
Message-Id: <200201160406.XAA28995@mercury.mv.net>
Content-Type: text/plain; charset=US-ASCII
From: jeff millar <jeff@wa1hco.mv.com>
Organization: me? organized?
To: linux-kernel@vger.kernel.org
Subject: Fwd: cml2-2.1.3 bug report
Date: Tue, 15 Jan 2002 23:06:08 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sent this to Eric privately with a lot of data, but maybe someone else can
jump in with an opinion about they way make oldconfig _should_ work.

Several items...

1. Make oldconfig doesn't behave like cml1.  With cml1, we would patch the
kernel or copy in a backup .config file and run make oldconfig.  It would do
its thing for 30 seconds and be done...no (or few) questions asked.  With
CML2, I get an endless series of questions about each possible configuration
item...much like "make config" does.

I just want make oldconfig to get ready for make dep with the minimum of
fuss. It's ok to ask about new configuration items but not a bunch of stuff
already set.

2. Something triggers the building of "everything" modular, like _all_ the
network cards, I2O, IEEE1394, etc.  You implied in an earlier email that
selecting modules leads to this.  But, I just want to build a few modules
because it takes less time and disk space and it easier to audit
/lib/modules/2.4.x/ results.   Besides with bleeding edge kernels, often lots
of drivers don't compile correctly. My original .config has m where I want it
and setting m a bunch more places means I just have to go around and shut off
hundreds of things.
