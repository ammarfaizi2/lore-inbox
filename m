Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132601AbRDEK6z>; Thu, 5 Apr 2001 06:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132606AbRDEK6q>; Thu, 5 Apr 2001 06:58:46 -0400
Received: from mail-dns1-nj.dialogic.com ([146.152.228.10]:39950 "EHLO
	mail-dns1-nj.dialogic.com") by vger.kernel.org with ESMTP
	id <S132601AbRDEK6i>; Thu, 5 Apr 2001 06:58:38 -0400
Message-ID: <EFC879D09684D211B9C20060972035B1D46A39@exchange2ca.sv.dialogic.com>
From: "Miller, Brendan" <Brendan.Miller@Dialogic.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Proper way to release binary-only driver?
Date: Thu, 5 Apr 2001 06:58:34 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have the need to distribute a binary-only driver (no flames, please), but
I am not certain how to build it so that it can be used on multiple kernel
versions.  (Or is this impossible?)

I didn't find any "HOWTO (or recommendation) for proper binary-only driver
release etiquette", so if there are some preferred means, please let me
know.

I specifically had issues with the whole MODVERSIONS thing.  I can include
<linux/verion.h> and <linux/config.h> to get the right CONFIG_MODVERSIONS
macro definitions, and then include <linux/modversions.h> as appropriate.
The end result is a driver with symbols whose names are mangled to match the
modversion-enabled mangling of a modversion-enabled kernel.  This is good if
I release on the same kernel version.

Obviously, if I use a different kernel the module refuses to load.  My first
guess was to get rid of the module-versioning stuff so that the symbols are
not mangled, and this seems to work, except that I must use insmod -f module
for kernels with a different version than what I built with.

So, if there are guides that I didn't find, or ones on this list that
someone things I should use, please let me know.  Or at least comment on my
chosen way of doing things.  It's this sort of thing that reinforces a
source form driver is the way to release stuff--then it can be built
alongside the user's kernel tree...

Please cc: me as I am not subscribed.

Brendan Miller
Dialogic, An Intel Company

