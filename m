Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266509AbUAWEO5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 23:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUAWEO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 23:14:57 -0500
Received: from usermail.com ([216.150.205.170]:12161 "EHLO usermail.com")
	by vger.kernel.org with ESMTP id S266509AbUAWEOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 23:14:54 -0500
Date: Fri, 23 Jan 2004 04:21:35 +0000
To: linux-kernel@vger.kernel.org
Subject: IDE compilation(etc) errors
Message-ID: <20040123042135.GA834@darius>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Tom Barnes-Lawrence <tomble@usermail.com>
X-Usermail.com-MailScanner-Information: Please contact the ISP for more information
X-Usermail.com-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(NOTE: please CC any replies to me, I'm not on the list)
Hi, I'm a long-term Linux user, but when I recently installed
2.6 I hadn't compiled a kernel for a long time, so I couldn't
remember stuff. Apologies if this issue has been addressed before,
I couldn't find it in the archives or the FAQs, etc.

OK: I use SCSI, I have various SCSI devices, and I *boot* from
SCSI. but I also have an IDE DVD drive.

I'm not using an initrd image (because you lot neglected to mention
which damned mkinitrd version I'd need for it) and therefore I
installed my kernel the old fashioned way: stuff necessary
for booting compiled in, everything else as modules under
/lib/modules, and yes, I *did* install the kernel too.

So: SCSI, my adapter, and sd are compiled in, and (the first
attempt, at least) IDE, and everything IDE related I built
as *modules*. When I did make modules_install, it churned
out a lot of warnings about various functions not being found
for the modules. I assumed they would be found later.

Then, when I rebooted with the new kernel, sure enough, I found
*no* IDE related kernel module I could load that didn't have
unresolved symbols. Perhaps there was supposed to be some
weird invocation of modprobe or insmod to load them all at
once or something, but if so, news to me.

When 2.6.1 came out, I installed it (partly as I also thought I was
leaking memory) and tried some other compile options, but these
didn't help. I then tried compiling the base IDE support as
compiled-in rather than a module. But doing this, the actual
kernel compilation crashed near the end, something about compiling
built-in/init or something like that.

 I logged (most of) the errors produced from that, I have
/proc/config.gz (with the IDE as modules setting), and I
probably still have the .config file for the failed compilation
(with IDE compiled-in). If anybody on the list thinks any of these
would be of use, they should let me know which, and whether
to send the info to them directly or to the whole list.

 I figure that either this situation I've found is a bug, or
if the set of compilation-options I chose is inappropriate, then
the config scripts must be wrong for letting me make it
(hence another bug), or the configuration help or other
documentation needs improving. Apart from that, I'd quite like
to know what I should have done right.

Thanks in advance,
 Tom Barnes-Lawrence
(to reiterate: please CC me replies, I'm not on the list)
