Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276953AbRJKVRq>; Thu, 11 Oct 2001 17:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276945AbRJKVRg>; Thu, 11 Oct 2001 17:17:36 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:32734 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S276953AbRJKVRZ>; Thu, 11 Oct 2001 17:17:25 -0400
Message-ID: <3BC60CCB.4F525A02@nortelnetworks.com>
Date: Thu, 11 Oct 2001 17:19:07 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Atwood <mra@pobox.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Module read a file?
In-Reply-To: <m38zehucml.fsf@flash.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Atwood wrote:
> 
> I'm modifying a PCMCIA driver module so that it can load new firmware
> into the card when it's inserted.
> 
> Rather than including the firmware inside the module's binary, I would
> much rather be able to read it out of the filesystem.
> 
> Are their any good examples of kernel code or kernel modules reading a
> file out of the filesystem that I could copy or at least look to for
> inspiration?

What about adding an ioctl() and making a userspace tool to pass the new
firmware down in a buffer?  This lets you do more complicated error-checking and
maybe some sort of validation of the firmware in userspace, saving on kernel
size.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
