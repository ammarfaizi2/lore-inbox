Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262596AbRFLRVn>; Tue, 12 Jun 2001 13:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261881AbRFLRVc>; Tue, 12 Jun 2001 13:21:32 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:18163 "EHLO ocs4.ocs-net")
	by vger.kernel.org with ESMTP id <S261289AbRFLRVX>;
	Tue, 12 Jun 2001 13:21:23 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Ulrich.Weigand@de.ibm.com
cc: "David S. Miller" <davem@redhat.com>, DJBARROW@de.ibm.com,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: bug in /net/core/dev.c 
In-Reply-To: Your message of "Tue, 12 Jun 2001 19:05:01 +0200."
             <C1256A69.005DDF6B.00@d12mta11.de.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Jun 2001 03:20:37 +1000
Message-ID: <11349.992366437@ocs4.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2001 19:05:01 +0200, 
Ulrich.Weigand@de.ibm.com wrote:
>Keith, it's probably much easier to just change arch/s390/Makefile
>to link the S/390 drivers *after* all common drivers by moving
>drivers/s390/io.o to $DRIVERS instead of $CORE_FILES.

That should work, although it would be yet another (and different) way
of doing things.  Your method would not work for SCSI drivers, they
have to go in the middle of drivers/scsi/Makefile.

That last point is only relevant if s390 supports native SCSI.  SCSI
disks emulating 33[89]0 does not count, the cpu does not issue SCSI
commands.  Are there any native SCSI devices for s390 or do they all
emulate IBM devices?  I can just see somebody trying to fit SCSI
commands into a CCW and IOB :).

