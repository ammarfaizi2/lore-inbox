Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422932AbWJQCcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422932AbWJQCcm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 22:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422970AbWJQCcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 22:32:42 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:17765 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1422932AbWJQCcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 22:32:41 -0400
Date: Mon, 16 Oct 2006 22:32:39 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: raw1394 problems galore FIXED!!!!!
In-reply-to: <45342789.2050506@verizon.net>
To: For users of Fedora Core releases <fedora-list@redhat.com>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, linux-kernel@vger.kernel.org,
       linux1394-user@lists.sourceforge.net
Message-id: <453440C7.2060800@verizon.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <4532DF11.9060704@verizon.net> <4533B889.5060302@s5r6.in-berlin.de>
 <4533DDA2.2050008@verizon.net> <4533FBD8.7050101@s5r6.in-berlin.de>
 <45342789.2050506@verizon.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

This is going to sound rather silly, because I did try a couple of 
earlier kernels before I started posting about this problem.

Tonight, I saw that kernel-2.6.18-1.2200.fc5.i686 was available, along 
with the matching kmod-ndiswrapper pieces and kmod-ntfs in versions 
2.6.18-1.2200.fc5 were available, so I installed them and rebooted.

Now kino-0.8 works sortof, wants to crash.
And kino-0.9.2 apparently works flawlessly, as does dvcont.

Looking into the logs, I see this during the boot:
Oct 16 20:20:29 diablo kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): 
IRQ=[10]  MMIO=[c0209000-c02097ff]  Max Packet=[2048]  IR/IT contexts=[
4/8]
Oct 16 20:20:29 diablo kernel: audit(1161044396.750:4): avc:  denied  { 
getattr } for  pid=1310 comm="pam_console_app" name="raw1394" dev=tmpfs
  ino=4494 scontext=system_u:system_r:pam_console_t:s0-s0:c0.c255 
tcontext=system_u:object_r:device_t:s0 tclass=chr_file
Oct 16 20:20:29 diablo kernel: audit(1161044396.750:5): avc:  denied  { 
setattr } for  pid=1310 comm="pam_console_app" name="raw1394" dev=tmpfs
  ino=4494 scontext=system_u:system_r:pam_console_t:s0-s0:c0.c255 
tcontext=system_u:object_r:device_t:s0 tclass=chr_file

And I believe the camera was plugged in and powered up during the boot 
as there are no further messages in the log & I've been playing with a 
very wide grin on my face for about half an hour with it.

So it was a kernel problem all along!

Just one question here.  Am I the only idiot that actually wants to do 
work on linux?  On second thought, I might not like the answer :-)

Anyway, end of thread, till the next time :)

-- 
Cheers, Gene

