Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129609AbQKMRU3>; Mon, 13 Nov 2000 12:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129599AbQKMRUS>; Mon, 13 Nov 2000 12:20:18 -0500
Received: from lonepeak.vii.com ([206.71.77.2]:42425 "EHLO vii.com")
	by vger.kernel.org with ESMTP id <S129551AbQKMRUH>;
	Mon, 13 Nov 2000 12:20:07 -0500
Message-ID: <3A1023F2.B1A81898@fatpipeinc.com>
Date: Mon, 13 Nov 2000 10:25:06 -0700
From: Damir Cosic <damir@fatpipeinc.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: problems with setting non-default modules path in 2.2.14
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I want to set my development machine so I have multiple
kernels that I can boot. I don't need different versions
of kernel, but only 2.2.14 compiled with different 
options (e.g. with/without kdb).

So I have two kernel images, default and debug. I also
compiled modules for both of these kernels and configured
lilo like this:

image = /boot/vmlinuz-pc97-2.2.14-modular
        label  = linux
        root   = /dev/hda1
        vga    = 274
        read-only
        append = "debug=2 noapic nosmp"
 
image = /boot/bzImage-debug
        label  = debug
        root   = /dev/hda1
        read-only
        append = "MODPATH=/lib/modules/2.2.14-debug/"

If I boot to debug kernel, 'cat /proc/cmdline' shows this:

BOOT_IMAGE=debug ro root=301 MODPATH=/lib/modules/2.2.14-debug/

but modules are not loaded. Also, I have this in my /etc/modules.conf:

path[usb]=/lib/modules/`uname -r`/`uname -v`
path[usb]=/lib/modules/`uname -r`
path[usb]=/lib/modules/
path[usb]=/lib/modules/default        

but this should affect only USB modules, which I don't use.
What am I missing here?

Thanks,

Damir
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
