Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319550AbSIHBp5>; Sat, 7 Sep 2002 21:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319551AbSIHBp5>; Sat, 7 Sep 2002 21:45:57 -0400
Received: from CPE00606767ed59.cpe.net.cable.rogers.com ([24.112.38.222]:27400
	"EHLO cpe00606767ed59.cpe.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S319550AbSIHBp4>; Sat, 7 Sep 2002 21:45:56 -0400
Date: Sat, 7 Sep 2002 21:51:55 -0400 (EDT)
From: "D. Hugh Redelmeier" <hugh@mimosa.com>
Reply-To: "D. Hugh Redelmeier" <hugh@mimosa.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       <Martin.Knoblauch@teraport.de>
Subject: clean before or after dep?
Message-ID: <Pine.LNX.4.44.0209072139470.21724-100000@redshift.mimosa.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a problem building a Red Hat kernel
(kernel-source-2.4.18-10).

It looks a lot like:
	<http://www.van-dijk.net/linuxkernel/200223/0349.html>

The error message is:
	make[4]: *** No rule to make target `/usr/src/linux-2.4.18-10/drivers/pci/devlist.h', needed by `names.o'.  Stop.

The fix proposed in <http://www.van-dijk.net/linuxkernel/200223/0432.html>
is to reverse the order of clean and dep:

     a kind soul pointed out that I should do:

    make clean dep
    make bzimage

    instead. Works. Learned a new trick :-)

Now this seems to contradict
	<http://www.tldp.org/HOWTO/Kernel-HOWTO-2.html#ss2.3>
which specifies, in step 5:
	bash# make dep
	bash# make clean

Which is the right order for clean and dep?

I've always assumed that they could be combined, as in:
	bash# make dep clean
Am I wrong?

Where is this documented?

Hugh Redelmeier
hugh@mimosa.com  voice: +1 416 482-8253

