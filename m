Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264621AbSIQWVm>; Tue, 17 Sep 2002 18:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264643AbSIQWVm>; Tue, 17 Sep 2002 18:21:42 -0400
Received: from air-2.osdl.org ([65.172.181.6]:60172 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264621AbSIQWVl>;
	Tue, 17 Sep 2002 18:21:41 -0400
Date: Tue, 17 Sep 2002 15:23:26 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Thomas Dodd <ted@cypress.com>
cc: <linux-kernel@vger.kernel.org>, Rogier Wolff <R.E.Wolff@bitwizard.nl>,
       <gen-lists@blueyonder.co.uk>, <linux-usb-users@lists.sourceforge.net>
Subject: Re: [Linux-usb-users] Re: Problems accessing USB Mass Storage
In-Reply-To: <3D87AA0D.6040600@cypress.com>
Message-ID: <Pine.LNX.4.33L2.0209171520230.14033-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2002, Thomas Dodd wrote:

| Rogier Wolff wrote:
| > On Tue, Sep 17, 2002 at 10:13:13PM +0100, Mark C wrote:
|
| > When dd is told to skip a certain number of input blocks it doesn't
| > seek past them, but reads them and then discards them. Thus if you're
| > not supposed to read sectors 1-100 then this will not work.
|
| Fair enough. I, and the others though it did a seek.
|
| > Try the following program:
| <snip>
| > with the command:
| >
| > 	dd if=/dev/sda of=firstpart
| >
| > (Get the partition table)
| >
| > 	(seek 0x100000;dd of=secondpart) < /dev/sda
| >
| > Get everything beyond 1Mb. If this works, then we have to figure out
| > how low we can make the "0x100000" number to get all of the data.
| >
| > Hypothesis: The partition table specifies that the data starts
| > on sector 200, and they didn't implement sectors 1-199.....
|
| Where did the sector 200 come from?
| Something in the dmesg output from before?
| (I don't really grok SCSI or USB at that level :( )

I think that's part of the hypothesis, but if we can read the
first sector, it should be trivial to decode the partition table,
if it's a typical DOS/Windows/PC-type partition table.

If someone can read the first sector, I'll be glad to decode it;
just send it.

-- 
~Randy
"Linux is not a research project. Never was, never will be."
  -- Linus, 2002-09-02

