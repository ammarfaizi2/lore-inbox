Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbUKCWxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbUKCWxl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 17:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbUKCWxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 17:53:02 -0500
Received: from minimail.digi.com ([204.221.110.13]:5985 "EHLO
	minimail.digi.com") by vger.kernel.org with ESMTP id S261954AbUKCWfv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 17:35:51 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: patch for sysfs in the cyclades driver
Date: Wed, 3 Nov 2004 16:35:44 -0600
Message-ID: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D81D@minimail.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: patch for sysfs in the cyclades driver
Thread-Index: AcTB616JedvTmaxkQqibE7pd4Ad74QABhevg
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Greg KH" <greg@kroah.com>
Cc: <germano.barreiro@cyclades.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Your driver can use whatever name you wanted, as long as it's the
> LANNANA name that you asked for and were assigned.  We do have
standards
> for a good reason, and the kernel will follow them.

>That being said, have your customers use a tool like udev.  Then they
> can name their tty devices whatever they want.  No limitations there
at
> all.

The problem is that LANANA assumes a product/driver
may only have a few tty's, say up to maybe 256 or so.

For example, we have a driver that can support 1000s or 10000s of tty's.

When dealing with that large amount of ttys, telling a customer
that they should remember that a tty down in Austin TX is ttyD19234,
and that the tty over in England is ttyD57267 is pretty ridiculous.

Our customers want to select a custom tty name base,
as well as a custom tty port number...
This way they can use logical names in an "area" specific range.

For example, maybe they have 10 16 port units in down in Texas,
they may want to group them as /dev/ttytx000 to /dev/ttytx159,
and the guy in england might want to name theirs
/dev/ttyengland_a to /dev/ttyengland_h

I agree using udev is a solution to the final name problem in /dev,
as long as they are using 2.6, (altough I have to support 2.4 as well).

But using udev still doesn't allow me to create that custom name in
/sys/class/tty.

I understand this is where you would say we should use the ttyD12143
value,
but I feel that it simply doesn't show the "linkage" between that value
and the "custom" name in /dev as easily as it would if I could create a
custom name for the tty in /sys/class/tty.

Scott







