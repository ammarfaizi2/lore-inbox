Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRACXBj>; Wed, 3 Jan 2001 18:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRACXBT>; Wed, 3 Jan 2001 18:01:19 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25611 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129267AbRACXBO>; Wed, 3 Jan 2001 18:01:14 -0500
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking bug
To: karrde@callisto.yi.org (Dan Aloni)
Date: Wed, 3 Jan 2001 23:02:12 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel), mark@itsolve.co.uk
In-Reply-To: <Pine.LNX.4.21.0101032259550.20246-100000@callisto.yi.org> from "Dan Aloni" at Jan 03, 2001 11:13:31 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Dwv9-0004m4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Linux, they use INT 80 system calls to execute functions in the kernel
> as root, when the stack is smashed as a result of a buffer overflow bug in
> various server software.
> 
> This preliminary, small patch prevents execution of system calls which
> were executed from a writable segment. It was tested and seems to work,
> without breaking anything. It also reports of such calls by using printk.

And I swap the int80 for a jmp to an int80 at a predictable location in ld.so

If you are going to do stack tricks then look at Solar Designers patches, he
has at least worked through the issues and even thought about using null bytes
in jump targets for libraries to stop some operations (string stuff)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
