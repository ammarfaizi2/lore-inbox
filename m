Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbTHJKRb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 06:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTHJKRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 06:17:31 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:57769 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262093AbTHJKRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 06:17:30 -0400
Date: Sun, 10 Aug 2003 12:17:22 +0200 (MEST)
Message-Id: <200308101017.h7AAHM5X004822@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: alan@lxorguk.ukuu.org.uk, geert@linux-m68k.org
Subject: Re: PATCH: mouse and keyboard by default if not embedded
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Aug 2003 10:42:27 +0200 (MEST), Geert Uytterhoeven wrote:
>>  config INPUT_MOUSEDEV_PSAUX
>> -	bool "Provide legacy /dev/psaux device"
>> +	bool "Provide legacy /dev/psaux device" if EMBEDDED
>
>Now INPUT_MOUSEDEV_PSAUX is always (on non-embedded machines) forced to true,
>even on machines without PS/2 keyboard/mouse hardware. Is that OK?

No it is not. I had to set CONFIG_EMBEDDED on my P4 (definitely
not embedded) to get rid of PSAUX. My P4 uses a nice serial mouse,
and I neither need nor want kernel mouse support.

I can understand the desire to provide safe defaults for newbies
doing oldconfig on 2.4 .configs, but the !EMBEDDED implies mouse
change is too rigid.
