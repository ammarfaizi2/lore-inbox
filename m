Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270258AbRHSIwC>; Sun, 19 Aug 2001 04:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270263AbRHSIvw>; Sun, 19 Aug 2001 04:51:52 -0400
Received: from mail4.svr.pol.co.uk ([195.92.193.211]:36418 "EHLO
	mail4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S270258AbRHSIvp>; Sun, 19 Aug 2001 04:51:45 -0400
Message-ID: <3B7F7E2B.2090601@humboldt.co.uk>
Date: Sun, 19 Aug 2001 09:51:55 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <Pine.LNX.3.95.1010817152158.4584B-100000@chaos.analogic.com>	<3B7E2CA5.50904@humboldt.co.uk> <m1itflocl7.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
  > I'm curious was this embedded system or was it a stock PowerPC.  I don't
  >  know of any off the shelf machines that come with BIOS source code.

It's a custom embedded system.  The designers have a few details and a
picture (the BIOS runs on cases 1 and 3) here:
http://www.varisys.co.uk/custom.html

The BIOS code is at
http://www.humboldt.co.uk/gbios.html

The BIOS is actually scriptable in TCL (Python or Perl wouldn't fit in 
the ROM). I'll port the latest version back to the Sandpoint reference 
platform soon.

  > So the attacker has two way to attack your machine.  Attempt to break
  > in while it is still running.  Put in a minimal boot cd and press
  > reset and see how much is recovered.  Generally breaking should prove
  > the more fruitful course, but the fact that reset preseves all of the
  > memory, means it simply is not safe for someone to have physical
  > access to your machine while the power is on.

Approximately true. If you have ECC memory then it will have to be 
cleared in the BIOS, because of write-back caching. The first time you 
write to a memory location, the processor reads in the whole cache line 
containing that information. If the memory wasn't cleared, the ECC codes 
for the data are wrong, and you get an unrecoverable ECC error 
interrupt. What actually happens probably depends on the BIOS version.


-- 
Adrian Cox   http://www.humboldt.co.uk/


