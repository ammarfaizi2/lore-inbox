Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264577AbUGRWwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264577AbUGRWwn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 18:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264585AbUGRWwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 18:52:42 -0400
Received: from hell.org.pl ([212.244.218.42]:51218 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S264577AbUGRWwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 18:52:41 -0400
Date: Mon, 19 Jul 2004 00:52:47 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Video memory corruption during suspend
Message-ID: <20040718225247.GA30971@hell.org.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	acpi-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm having an odd problem with video memory being corrupted during suspend.

My setup is:
ASUS L3800C laptop, Radeon M7, i845 chipset, using DRI and radeonfb.

Note that this is not specific to the kernel used, as I've been seeing 
similar corruption every now and then, most recently under 2.6.7 +
ACPICA20040715 + swsusp2.0.0.100 (S3, S4), but also under 2.4 with S1 (but 
not with S4/swsusp2).

I have a very simple script I use to suspend (i.e. basically echo $arg >
/proc/acpi/sleep), which is usually started by acpid. Once the script is
triggered (by pressing power / sleep button) and an X session is running, 
various red and green patches appear on the screen (the background image
and the tinted terminal emulator), followed by the VT switch the PM code
does. After resume and subsequent VT switch by the PM code the corruption
is still visible. The screen is properly restored by a manual VT switch.
The corruption is clearly related to the existing background pixmap, as
moving the windows does not change its pattern. Oddly enough, starting a GL
app such as glxgears and moving it into and out of focus also properly
restores the screen.

I'll be happy to provide any useful information.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
