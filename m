Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267690AbTAMBI6>; Sun, 12 Jan 2003 20:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267698AbTAMBI6>; Sun, 12 Jan 2003 20:08:58 -0500
Received: from air-2.osdl.org ([65.172.181.6]:18893 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267690AbTAMBI4>;
	Sun, 12 Jan 2003 20:08:56 -0500
From: Randy Dunlap <rddunlap@osdl.org>
Message-ID: <1873.4.64.197.173.1042420665.squirrel@www.osdl.org>
Date: Sun, 12 Jan 2003 17:17:45 -0800 (PST)
Subject: Re: Using lilo to boot off any drive ...
To: <wa@almesberger.net>
In-Reply-To: <20030112195741.B6866@almesberger.net>
References: <20030110210035.76482.qmail@web20502.mail.yahoo.com>
        <20030112195741.B6866@almesberger.net>
X-Priority: 3
Importance: Normal
Cc: <m_lachwani@yahoo.com>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Manish Lachwani wrote:
>> When the control is transferred to lilo on sda (sdb
>> actually), is there a way for me to boot off sdd now
>> (which was previously sde)? I mean, is there any way
>> that lilo can load the appropriate kernel image?
>
> You could have two independent installations of LILO, one on
> sda, and one on sdb, where the latter accesses no files from
> sda and defines the disk numbers (for the BIOS) the way they
> look when sda is removed.
>
> Then, you probably want to rename /sbin/lilo to /sbin/lilo.bin
> or such, and write a script /sbin/lilo that generates the
> modified lilo.conf files, and updates both instances of LILO.

This is probably too simplistic to be helpful..., but what I
do is put a modified/stripped-down bootsect.S (512 bytes) on a
floppy.  I can (theoretically) tell that code which hard drive
to boot from (like 0x80 or 0x81).  I haven't tried it with
more than 2 drives (don't have more than 2 drives).

And I install LILO on each target boot drive.  LILO complains
a little bit, but it still works.
~Randy



