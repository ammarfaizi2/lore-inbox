Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbWDITX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWDITX1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 15:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWDITX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 15:23:27 -0400
Received: from khc.piap.pl ([195.187.100.11]:42512 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750915AbWDITX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 15:23:26 -0400
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: linux list <linux-kernel@vger.kernel.org>
Subject: Re: Black box flight recorder for Linux
References: <44379AB8.6050808@superbug.co.uk>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 09 Apr 2006 21:23:16 +0200
In-Reply-To: <44379AB8.6050808@superbug.co.uk> (James Courtier-Dutton's message of "Sat, 08 Apr 2006 12:12:56 +0100")
Message-ID: <m3psjqeeor.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton <James@superbug.co.uk> writes:

> Now, the question I have is, if I write values to RAM, do any of those
> values survive a reset? If any did survive, one could use them to
> store oops output in. I am currently only interested in Intel CPU and
> AMD CPU based motherboards. If only some values survived, one could
> use some sort of redundant encoding so the good values could be
> recovered.
>
> The main advantage of something like this would be for newer
> motherboards that are around now that don't have a serial port.

Interesting idea.

I think the most trivial and reliable way would be to solder some
I^2 or similar EEPROM chip to, for example, parallel port connector.

Most motherboards have an internal I^2C bus / SMBus (for reading RAM
types and for other things) and I think it could be used to connect
the EEPROM instead of external port.

There are 512 Kbit (64 KB) and 1 Mbit (128 KB) EEPROMs available -
there is plenty of space not only for crash dump but for whole dmesg.
-- 
Krzysztof Halasa
