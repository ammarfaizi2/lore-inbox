Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283507AbRK3FM4>; Fri, 30 Nov 2001 00:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283508AbRK3FMq>; Fri, 30 Nov 2001 00:12:46 -0500
Received: from smtp.ca.inter.net ([38.210.35.210]:1447 "EHLO smtp.ca.inter.net")
	by vger.kernel.org with ESMTP id <S283507AbRK3FMg>;
	Fri, 30 Nov 2001 00:12:36 -0500
Message-ID: <3C071573.5090EB1@interlog.com>
Date: Fri, 30 Nov 2001 00:13:23 -0500
From: Douglas Gilbert <dgilbert@interlog.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Patch to update scsi_debug.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev <zaitcev@redhat.com> wrote:

> I would like to have scsi_debug with a variable number 
> of hosts. Patch is attached. Does anyone object to the 
> demise of scsi_debug.h?

<snipped patch/>

Pete,
Maybe you may like to consider this effort. Apart from allowing
extra hosts (hundreds of them via boot/module option) it is
like a RAM disk. The default RAM allocation is 8 MB which
can be overridden by a boot/module option. You can
run fdisk on it, make a fs, mount it, etc.

See:
http://www.torque.net/sg/sdebug.html

It runs properly on SMP (Eric's didn't) and supports a
reasonable number of SCSI commands including READ_16 and
WRITE_16. I used the latter 2 commands to test (via sg)
that the recently added 16 byte CDBs worked.

BTW I kept scsi_debug.h as most other SCSI adapter drivers
have .h and .c components.

Doug Gilbert
