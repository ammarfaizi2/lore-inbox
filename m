Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbVIDWKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbVIDWKk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 18:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbVIDWKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 18:10:40 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:4995 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932095AbVIDWKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 18:10:39 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, Jan De Luyck <lkml@kcore.org>,
       USB Storage list <usb-storage@lists.one-eyed-alien.net>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Genesys USB 2.0 enclosures
Date: Mon, 05 Sep 2005 08:10:08 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <6brmh15ti5rqcb0iia4t4tg7gpm8499at9@4ax.com>
References: <200509031812.54753.lkml@kcore.org> <Pine.LNX.4.44L0.0509032151040.5675-100000@netrider.rowland.org> <20050904210446.GA16290@one-eyed-alien.net>
In-Reply-To: <20050904210446.GA16290@one-eyed-alien.net>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Sep 2005 14:04:46 -0700, Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:

>On Sat, Sep 03, 2005 at 09:53:19PM -0400, Alan Stern wrote:
>> On Sat, 3 Sep 2005, Jan De Luyck wrote:
>> 
>> > I've posted in the past about problems with these enclosures - increasing the 
>> > delay seems to fix it, albeit temporarily. The further you go in using the 
>> > disk in such an enclosure, the higher the udelay() had to be - atleast that's 
>> > what I'm seeing here (I've got two of these now :/ )
>> > 
>> > One permanent fix is adding a powered USB-hub in between the drive enclosures 
>> > and the computer. Since I've done that, I've no longer seen any of the 
>> > problems (i've attached the 'fault' log). Weird but true, since the drives 
>> > come with their own powersupply.
>> > 
>> > Hope this helps anyone in the future running into the same problem.
>> 
>> This one certainly goes into the Bizarro file.
>> 
>> Just out of curiosity -- when you use the powered hub, does the drive work 
>> even if you remove that delay completely?
>
>Aren't USB 2.0 hubs more "intelligent" as part of the requirement to
>support 1.1 and 2.0 devices?  I wonder if it's really a 2.0 drive, and if
>the timing is different enough with the hub to make a difference.

Fixed a USB powered (two USB plugs) Genesys based 2.5" HDD enclosure with 
extra 5V supply bypass capacitors, the HDD was shutting down without loss 
of data with a 'soft' 5V supply.  Now USB drive works everywhere except a 
laptop with a single USB.  HDD uses 700mA, USB is spec'd 500mA per socket.

Some bugs are the hardware :o)

Grant.

