Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130762AbRBCXB2>; Sat, 3 Feb 2001 18:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130843AbRBCXBT>; Sat, 3 Feb 2001 18:01:19 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:50190 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130762AbRBCXBI>;
	Sat, 3 Feb 2001 18:01:08 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Viktor Rosenfeld <rosenfel@informatik.hu-berlin.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG?] ISA-PnP and 3c509 NIC won't work together 
In-Reply-To: Your message of "Sat, 03 Feb 2001 18:54:44 BST."
             <3A7C45E4.15C470A3@informatik.hu-berlin.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 04 Feb 2001 10:01:00 +1100
Message-ID: <17882.981241260@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 Feb 2001 18:54:44 +0100, 
Viktor Rosenfeld <rosenfel@informatik.hu-berlin.de> wrote:
>With ISA-PnP compiled in, and 3c509 support compiled as module:
># modprobe 3c509
>/lib/modules/2.4.1/kernel/drivers/net/3c509.o: invalid parameter parm_io
>/lib/modules/2.4.1/kernel/drivers/net/3c509.o: insmod
>/lib/modules/2.4.1/kernel/drivers/net/3c509.o failed
>/lib/modules/2.4.1/kernel/drivers/net/3c509.o: insmod 3c509 failed

You passed an unknown parameter io_parm to 3c509 and insmod rejected
it.  This has nothing to do with isa-pnp nor the 3c509, it is a pure
user error.  Correct modules.conf before doing anything else.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
