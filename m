Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261438AbTCGHj5>; Fri, 7 Mar 2003 02:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261435AbTCGHj4>; Fri, 7 Mar 2003 02:39:56 -0500
Received: from air-2.osdl.org ([65.172.181.6]:28093 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261431AbTCGHjt>;
	Fri, 7 Mar 2003 02:39:49 -0500
Message-ID: <32995.4.64.238.61.1047023411.squirrel@www.osdl.org>
Date: Thu, 6 Mar 2003 23:50:11 -0800 (PST)
Subject: Re: [Linux-NTFS-Dev] ntfs OOPS (2.5.63)
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <aia21@cantab.net>
In-Reply-To: <Pine.SOL.3.96.1030306122732.1983B-100000@draco.cus.cam.ac.uk>
References: <Pine.LNX.4.30.0303060716390.28143-100000@divine.city.tvnet.hu>
        <Pine.SOL.3.96.1030306122732.1983B-100000@draco.cus.cam.ac.uk>
X-Priority: 3
Importance: Normal
Cc: <szaka@sienet.hu>, <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-ntfs-dev@lists.sourceforge.net>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 6 Mar 2003, Szakacsits Szabolcs wrote:
>> On Wed, 5 Mar 2003, Randy.Dunlap wrote:
>>
>> > > Could you try to turn on debugging in the NTFS driver (compile option
>> in the menus), then once ntfs module is loaded (or otherwise anytime)
>> as root do:
>> > >
>> > > echo -1 > /proc/sys/fs/ntfs-debug

Did that, got lots of output, but the oops isn't reproducible
AFAIK, so I haven't collected all of that debug output.

>> > > Then mount and to the directory changes. Assuming that you get the bug
>> again could you send me the captured kernel log output? (Note there
>> will be massive amounts of output.)
>> > >
>> > > The code looks ok and I can't reproduce here so it would be helpful to
>> see if there are any oddities on your partition. Just to make sure it
>> is not the compiler, could you do a "make fs/ntfs/inode.S" and send me
>> that as well?

The .config file, gcc -v output, and /proc/cpuinfo are added as
attachments at
  http://bugme.osdl.org/show_bug.cgi?id=432

objdump disassembly and make fs/ntfs/inode.s files are also
attached there.

I tried to decode the disassembly, got lots of it done,
but I bogged down on something that may be outside of the
NTFS realm.  I have ALL kernel hacking options enabled
(=y), and it's a bit hairy (for me) to decode all of the
extra/added code, and this may be where the oops is
happening.  Dunno really, just wanted to warn you.

Thanks,
~Randy



