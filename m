Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131386AbREHKCQ>; Tue, 8 May 2001 06:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131407AbREHKCG>; Tue, 8 May 2001 06:02:06 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:53764 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S131386AbREHKBw>; Tue, 8 May 2001 06:01:52 -0400
Date: Tue, 8 May 2001 12:01:08 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Sean Jones <sjones@ossm.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SPARC include problem
Message-ID: <20010508120108.A1802@arthur.ubicom.tudelft.nl>
In-Reply-To: <3AF71B1F.56FFCA16@ossm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AF71B1F.56FFCA16@ossm.edu>; from sjones@ossm.edu on Mon, May 07, 2001 at 05:01:03PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2001 at 05:01:03PM -0500, Sean Jones wrote:
> In compiling 2.4.4-ac5 for my SPARCStation 20, I had an error in the
> compile resulting from the inability to find a hw_irq.h in the
> include/asm directory. Do you know where I may be able to find such a
> file?

You don't. I discussed this last week with Russell King: the ARM port
also doesn't have the file hw_irq.h in include/asm-arm. According to
Russell it is only needed in the arch dependent subdirectories, and not
in the drivers.

Any driver that includes linux/irq.h is not written to be portable. The
only generic driver that includes it is driver/pcmcia/hd64465_ss.c, but
on second glance it's a Hitachi HD64465 specific driver anyway.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
