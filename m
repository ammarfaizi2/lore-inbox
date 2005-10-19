Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbVJSR6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbVJSR6Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 13:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVJSR6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 13:58:24 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:48714 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751194AbVJSR6X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 13:58:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hf4tSlaia7jbnlPDTSH1ynZdHf/yILgDBxXjHc34OjCODYyYkQ5X64eXiepyDVJnY0+BNdrJ3p6k2zMLvmG30PW9JbwilRyyVl4QMjJxv547EId9udo3xgvlUfxNJv0sSFSF3OieoCW/ZTG28mbeqsXD+8os6KK25of6vkU7BDM=
Message-ID: <908666c60510191058h6e87b9c5y@mail.gmail.com>
Date: Wed, 19 Oct 2005 19:58:22 +0200
From: Pierre Michon <pierre.michon@gmail.com>
To: loic@gnu.org
Subject: Re: freebox possible GPL violation
Cc: Pierre Michon <pierre@no-spam.org>, linux-kernel@vger.kernel.org,
       legal@lists.gpl-violations.org
In-Reply-To: <17232.52887.293668.390641@allin.dachary.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051005084738.GA29944@linux.ensimag.fr>
	 <17232.52887.293668.390641@allin.dachary.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2005/10/15, Loic Dachary <loic@gnu.org>:
>         I believe that a customer could ask for the corresponding sources
> to Free if she/he got a copy of the binary out of the freebox. Does anyone
> have such a binary ?
But those ISP does everything in order the user couldn't touch the
firmware because they are frightened that the user could modify it and
does things that wasn't planed (record live tv stream for example).

For that they :
- disable all debug functions on customers boxes (serial port, jtag, ...).
- download the firmware via encrypted protocol (https, ...)
- check the integrity of the bootloader, firmware server, firmware.
- encrypted all rescue firmware that could be present on user computer.

So one way of recovering the firmware could be to unsold the flash
chip and read it on another board.

An other way will be to try to renable debug functions by soldering
component on the board.

But it will be very expensive and need special competences (and
without the datasheet of the board could be very hard...).


>
>  > the fimware. So we could assume that at least a mininal system (Linux
>  > kernel + some utils) is keep in rom).
>
>         Could someone provide a hard proof of this ?
>
No without reading the flash chip.

What I have seen for the boards like freebox in my company :
- the bootloader try to load the firmware in flash
- if it fails, it try to read a rescue firmware. That rescue firmware
is minimal and will only allow to enable ADSL line and download a new
firmware in the flash and reboot.
- if it fails, the bootloader will try to load a encrypted firmware
from local Ethernet LAN (bootp, ...) and reboot.

But there no way to know what exactly does the freebox (may be try to
find the flash chip and its size)...

Pierre

PS : Does we need the binary image in order to ask for the source code ?
In this case, with Embedded devices that hide the firmware it will be
very difficult to make GPL apply...
