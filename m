Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbTIBX7q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 19:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbTIBX7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 19:59:46 -0400
Received: from hoemail2.lucent.com ([192.11.226.163]:13257 "EHLO
	hoemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S261325AbTIBX7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 19:59:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16213.12008.527588.874265@gargle.gargle.HOWL>
Date: Tue, 2 Sep 2003 19:59:36 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Greg KH <greg@kroah.com>
Cc: John Stoffel <stoffel@lucent.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.0-test4-mm4 - USD disconnect oops
In-Reply-To: <20030901065928.GB22647@kroah.com>
References: <16210.44543.579049.520185@gargle.gargle.HOWL>
	<20030901065928.GB22647@kroah.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Greg" == Greg KH <greg@kroah.com> writes:

>> Here's the backtrace, my .config is at the end.  It's a PIII Xeon 2 x
>> 550mhz, Dell Precision 610 motherboard/system, 768mb of RAM.  The only
>> USB devices are the controllers and the CompactFlash reader, which
>> works great under 2.4.  

Greg> Does this happen on 2.6.0-test4?  (no -mm).

Well, I can now use the usb-storage device under 2.6.0-test4 without
any problems, but I just did a quick test.  So there's something in
-mm4 which is messing me and usb in general up.  I've made the
following changes though, so I should go back and check:

- upgrade to module-init-tools-0.9.13
- upgrade to hotplug-2003_08_05-1
	     hotplug-base-2003_08_05-1

I'll see if I can figure out what changed in the -mm4 patch to cause
this problem.  Could it be the kobject patch Akpm posted?  It looks
like the oops I've gotten.

The next big thing to do is to get my Dell Precision 610 to recognize
it's CS4236B ISA sound card properly with ALSA in 2.6.0-t4...

Thanks Greg!

John

