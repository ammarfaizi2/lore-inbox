Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbVIHTZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbVIHTZO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 15:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbVIHTZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 15:25:14 -0400
Received: from pop.gmx.de ([213.165.64.20]:43447 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964944AbVIHTZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 15:25:12 -0400
X-Authenticated: #28678167
Message-ID: <432090AE.2030200@gmx.net>
Date: Thu, 08 Sep 2005 21:27:42 +0200
From: Andreas Baer <lnx1@gmx.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050902)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Large File Support in Kernel 2.6
References: <20050904203725.GB4715@redhat.com> <20050902060830.84977.qmail@web50208.mail.yahoo.com> <200509041549.17512.vda@ilport.com.ua> <200509041144.13145.paul@misner.org> <84144f02050904100721d3844d@mail.gmail.com> <6880bed305090410127f82a59f@mail.gmail.com> <20050904193350.GA3741@stusta.de> <6880bed305090413132c37fed3@mail.gmail.com> <20050904203725.GB4715@redhat.com> <431F1778.5050200@tmr.com> <5.2.1.1.2.20050907194344.00c2bea8@pop.gmx.net> <43208B77.9060009@tmr.com>
In-Reply-To: <43208B77.9060009@tmr.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a question about the Large File Support using Linux and glibc 2.3
on a 32-Bit machine. What's the correct limit for the file size and the
file system using LFS (just for the kernel, not to mention filesystem
limits etc)?

I found two references:


"The 2.6 kernel imposes its own limits on the size of files and file
systems handled by it. These are as follows:
- file size: On 32-bit systems, files may not exceed the size of 2 TB.
- file system size: File systems may be up to 2e73 bytes large. However,
this limit is still out of reach for the currently available hardware."

Source:
http://www.novell.com/documentation/suse91/suselinux-adminguide/html/apas04.html


"Kernel 2.6: For both 32-bit systems with option CONFIG_LBD set and for
64-bit systems: The size of a file system is limited to 2e73 (far too
much for today). On 32-bit systems (without CONFIG_LBD set) the size of
a file is limited to 2 TiB. Note that not all filesystems and hardware
drivers might handle such large filesystems."

Source: http://www.suse.de/~aj/linux_lfs.html


I think it's 2TB for the file size and 2e73 for the file system, but I
don't understand the second reference and the part about the CONIFG_LBD.
What is exactly the CONFIG_LBD option?
