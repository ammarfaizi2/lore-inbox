Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264905AbSIQXHv>; Tue, 17 Sep 2002 19:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264909AbSIQXHv>; Tue, 17 Sep 2002 19:07:51 -0400
Received: from air-2.osdl.org ([65.172.181.6]:61968 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264905AbSIQXHu>;
	Tue, 17 Sep 2002 19:07:50 -0400
Date: Tue, 17 Sep 2002 16:09:34 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Mark C <gen-lists@blueyonder.co.uk>
cc: Patrick Mansfield <patmans@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-users <linux-usb-users@lists.sourceforge.net>
Subject: Re: [Linux-usb-users] Re: Problems accessing USB Mass Storage
In-Reply-To: <1032303080.1141.5.camel@stimpy.angelnet.internal>
Message-ID: <Pine.LNX.4.33L2.0209171559270.14033-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Sep 2002, Mark C wrote:

| On Tue, 2002-09-17 at 23:21, Patrick Mansfield wrote:
|
| > You should be able to run the equivalent:
| >
| > 	dd if=/dev/sda of=/dev/zero bs=512 count=8
|
| I done that and please find the output below:

So most (all?) of these don't work.

Have you tried Rogier's 'seek' program yet?

| sda: test WP failed, assume Write Enabled
|  sda: I/O error: dev 08:00, sector 0
|  I/O error: dev 08:00, sector 0
|  unable to read partition table

If sector 0 isn't readable, just use the secondpart instructions
that Rogier posted.  Start with a fairly large number (like he
used, was it 0x10000 ?).  If that works, use smaller values of
the seek offset and try to find the smallest value that still
works.  The first sector with the smallest value that works
_might_ be a master boot record/partition table with some useful
info in it, or it might just be a boot record followed by a
FAT filesystem, or something_else_who_knows_what.
Anyway, if you can do that, you can post the data and I'll take
a look at it.

-- 
~Randy
"Linux is not a research project. Never was, never will be."
  -- Linus, 2002-09-02

