Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbTFHLf3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 07:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbTFHLf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 07:35:29 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:59547 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261564AbTFHLf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 07:35:27 -0400
Date: Sun, 8 Jun 2003 12:54:02 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Miklas <public@mikl.as>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linksys WRT54G and the GPL
Message-ID: <20030608115402.GA19307@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Miklas <public@mikl.as>, linux-kernel@vger.kernel.org
References: <200306072241.23725.public@mikl.as>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306072241.23725.public@mikl.as>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 10:41:23PM -0400, Andrew Miklas wrote:
 > 1. Go to the following URL:
 >     http://www.linksys.com/download/firmware.asp?fwid=178
 > 
 > 2. Download the "firmware upgrade files":     
 > ftp://ftp.linksys.com/pub/network/WRT54G_1.02.1_US_code.bin
 >     (MD5SUM: b54475a81bc18462d3754f96c9c7cc0f)
 > 
 > 3. While it is downloading, confirm that there is nothing on the webpage to 
 > indicate that this binary contains GPLed software.
 > 
 > 4. Once the download is complete, copy the contents of the file from offset 
 > 0xC0020 onward into a new file.
 >     dd if=WRT54G_1.02.1_US_code.bin of=test.dump skip=24577c bs=32c
 > 
 > 5. Notice that this file is an image of a CramFS filesystem.
 >     Mount it.
 > 
 > 6. Explore the filesystem.  You will notice that the system appears to be 
 > based on Linux 2.4.5.
 >    Incidentally, there is at least one other GPLed project in the firmware: 
 > the BusyBox userland component: (http://www.busybox.net/)
 > 
 > 7. The Linux kernel (I think) is mixed up with a bunch of other stuff in:
 >     bin/boot.bin

Curiously, the Belkin products (http://networking.belkin.com) also seem
to be based upon the same source.  Looks like they could just be
rebranded firmware images with some features disabled.

Additionally, strings(1) output of firmware image may be interesting
to users of their 54g WAPs. Seems it has a lot more html pages inside
than what is documented. The 'low-end' version I bought doesn't mention
anything about firewall, dhcp, dns configuration, or parental controls,
however it's all in there if you know the right URLs. Fun.

		Dave

