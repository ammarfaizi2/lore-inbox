Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVHBIQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVHBIQv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 04:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVHBIQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 04:16:51 -0400
Received: from ds17.reliablehosting.com ([216.131.95.67]:60091 "EHLO
	ds17.reliablehosting.com") by vger.kernel.org with ESMTP
	id S261420AbVHBIQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 04:16:33 -0400
Message-ID: <42EF2BDE.5070107@bluebottle.com>
Date: Tue, 02 Aug 2005 12:16:30 +0400
From: Gene Pavlovsky <heilong@bluebottle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050727
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] user_vc_blank-0.1 (blank the console using a userspace
 helper)
Content-Type: multipart/mixed;
 boundary="------------000503050007030108050104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000503050007030108050104
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

http://bugzilla.kernel.org/show_bug.cgi?id=4767

I think it'd be very good to have a console_blank_hook handler that would call a
userspace program/script/generate hotplug event whatever. Currently, the console
can only be blanked using APM, so no options exist for people using ACPI. I've
got a Radeon graphics chip on my laptop, and the LCD backlight can be controlled
(on/off) using radeontool. If there was a userspace callback interface to
console blanking, I would just make a callback script that calls "radeontool
light off" on blank and "radeontool light on" on unblank - really easy. I think
this userspace console_blank_hook handler is very simple to put into kernel, but
I'm not a kernel developer myself, so wouldn't risk sending any patches (that
call system("some_script")), because I probably won't make things as they should
be in the kernel.


------- Additional Comment #1 From Eugene Pavlovsky 2005-06-29 06:46 -------

Created an attachment (id=5238)
implemented this functionality in a kernel module

I've actually checked the kernel sources on how this can be done and
implemented the proposed functionality in a kernel module. The module attaches
a console blank hook function that uses kernel's call_usermodehelper() to
execute /sbin/user_vc_blank (defined at compile-time) to blank/unblank the
console. I've written a sample script (which I use on my laptop) that uses
radeontool to turn the LCD backlight off/on. Maybe this functionality should be
moved to the kernel. On the other hand, as it still needs userspace utilities,
maybe it's better off as a module. Anyway, please give it a thought, or at
least made this module available.

-- 
The human knowledge belongs to the world

--------------000503050007030108050104
Content-Type: application/x-gzip;
 name="user_vc_blank-0.1.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="user_vc_blank-0.1.tar.gz"

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
8C/FWOooAFAAAA==
--------------000503050007030108050104--
