Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312458AbSC3MEx>; Sat, 30 Mar 2002 07:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312459AbSC3MEn>; Sat, 30 Mar 2002 07:04:43 -0500
Received: from khms.westfalen.de ([62.153.201.243]:27014 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S312458AbSC3MEc>; Sat, 30 Mar 2002 07:04:32 -0500
Date: 30 Mar 2002 12:06:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8LrTyWC1w-B@khms.westfalen.de>
In-Reply-To: <15524.45472.231096.377756@napali.hpl.hp.com>
Subject: Re: [PATCH] generic show_stack facility
X-Mailer: CrossPoint v3.12d.kh8 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davidm@napali.hpl.hp.com (David Mosberger)  wrote on 29.03.02 in <15524.45472.231096.377756@napali.hpl.hp.com>:

> As far as I know, the x86 version of show_trace() still relies on the
> fact that (a) return addresses are stored on the memory stack, (b)
> they are stored in the order in which the routines were called, and
> (c) that there aren't too many other values on the stack that look
> like kernel text addresses.  As long as an x86 compiler uses the CALL
> instruction, that should be the case.

(b) is certainly not necessarily true for architectures like PPC, but the  
rest seems fairly unobjectionable - assuming that you first flush out your  
registers so any addresses only in registers get put on the stack, too. At  
least outside of Forth, separate return stacks seem to be extremely rare.

And as for the possibility of using several registers for return addresses  
such that dumping them leaves them on the stack out of order, well, the  
only thing I can see to get the original order back is to consult debug  
information that says where, on every call, to look for the next-up return  
address. Which doesn't seem quite feasible with anything less than a full  
gdb to do it.

What I don't see is what connection this can possibly have to the  
prototype of a stack dump routine.

MfG Kai
