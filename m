Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276955AbRJKVZI>; Thu, 11 Oct 2001 17:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276951AbRJKVY6>; Thu, 11 Oct 2001 17:24:58 -0400
Received: from ip240.cvd2.rb1.bel.nwlink.com ([207.202.151.240]:42804 "EHLO
	zot.localdomain") by vger.kernel.org with ESMTP id <S276947AbRJKVYk>;
	Thu, 11 Oct 2001 17:24:40 -0400
To: "Christopher Friesen" <cfriesen@nortelnetworks.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Module read a file?
In-Reply-To: <m38zehucml.fsf@flash.localdomain>
	<3BC60CCB.4F525A02@nortelnetworks.com>
From: Mark Atwood <mra@pobox.com>
Date: 11 Oct 2001 14:25:09 -0700
In-Reply-To: "Christopher Friesen"'s message of "Thu, 11 Oct 2001 17:19:07 -0400"
Message-ID: <m3zo6xswcq.fsf@flash.localdomain>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Christopher Friesen" <cfriesen@nortelnetworks.com> writes:
> Mark Atwood wrote:
> > I'm modifying a PCMCIA driver module so that it can load new firmware
> > into the card when it's inserted.
> > Are their any good examples of kernel code or kernel modules reading a
> > file out of the filesystem that I could copy or at least look to for
> > inspiration?
> 
> What about adding an ioctl() and making a userspace tool to pass the
> new firmware down in a buffer?  This lets you do more complicated
> error-checking and maybe some sort of validation of the firmware in
> userspace, saving on kernel size.

Because the firmware is stored in volitile memory on the card, and
vanishes on a card reset or removal, and I would like to have it Just
Work with the pcmcia-cs package with minimal changes.

Having to remember "run this userspace tool after every card reset"
(which includes power suspends and so forth) would be a major pain.

Besides, the card already has a good validator in it.

-- 
Mark Atwood   | I'm wearing black only until I find something darker.
mra@pobox.com | http://www.pobox.com/~mra
