Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbTI0SFA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 14:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbTI0SFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 14:05:00 -0400
Received: from web40910.mail.yahoo.com ([66.218.78.207]:26203 "HELO
	web40910.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262130AbTI0SEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 14:04:51 -0400
Message-ID: <20030927180450.69071.qmail@web40910.mail.yahoo.com>
Date: Sat, 27 Sep 2003 11:04:50 -0700 (PDT)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: Kernel panic:Unable to mount root fs (2.6.0-test5)
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: jean-marc@spaggiari.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030927172902.GK7665@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Viro,

--- viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Sat, Sep 27, 2003 at 12:48:32PM -0400, Jean-Marc Spaggiari wrote:
>  
> > Here is what I can see on the screen :
> > 
> > floppy0: no floppy controllers found
> > RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> > loop: loaded (max 8 devices)
> > 8139too Fast Ethernet driver 0.9.26
> > eth0: Realtek RTL8139 at 0xe3809f00, 00:08:0d:89:3c:38, IRQ 5
> > mice: PS/2 mouse device common for all mice
> > Synaptics Touchpad, model: 1
> >  Firware: 5.9
> >  Sensor: 15
> >  ne absolute packet format
> >  Touchpad has extended capability bits
> >  -> multifinger detection
> >  -> palm detection
> > input: Synaptics TouchPad on isa0060/serio1
> > serio: i8042 AUX port at 0x60,0x64 irq 12
> > input: AT Set 2 keyboard on isa0060/serio0
> > serio: i8042 KBD port at 0x60, 0x64 irq 1
> > NET: Registred protocol family 2
> > IP: routing cache hash table of 4096 buckets, 32Kbytes
> > TCP: Hash tables configured (established 32768 bind 32768)
> > NET: Registerd protocol family 1
> > VFS: Cannont open root device "302" or unknown-block(3,2)
> > Please append a correct "root=" boot option
> > Kernel panics: VFS: Unable to mount root fr onunknown-block(3,2)
> 
> Which has one interesting thing and doesn't have another.
> 	1) kernel has no idea WTF major 3/minor 2 means.
> 	2) kernel hadn't even tried to look around for IDE disks
> 
> The most likely cause: IDE support is not turned on.  Check your .config -
> the interesting parts are CONFIG_BLK_DEV_IDE and CONFIG_BLK_DEV_IDEDISK.

I never thought of that. But if he had used make oldconfig, make xconfig or
copied a 2.4 .config into the source tree, how would CONFIG_BLK_DEV_IDE and
CONFIG_BLK_DEV_IDEDISK end up N? 

Brad

=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
