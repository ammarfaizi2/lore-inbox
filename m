Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265165AbTIJQYD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 12:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbTIJQXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 12:23:53 -0400
Received: from havoc.gtf.org ([63.247.75.124]:662 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S265158AbTIJQWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 12:22:43 -0400
Date: Wed, 10 Sep 2003 12:20:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marco Bertoncin - Sun Microsystems UK - Platform OS
	 Development Engineer <Marco.Bertoncin@Sun.COM>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NFS/MOUNT/sunrpc problem?
Message-ID: <20030910162054.GB29990@gtf.org>
References: <200309101437.h8AEbV108262@brk-mail1.uk.sun.com> <1063208491.32726.66.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063208491.32726.66.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 04:41:31PM +0100, Alan Cox wrote:
> On Mer, 2003-09-10 at 15:37, Marco Bertoncin - Sun Microsystems UK -
> Platform OS Development Engineer wrote:
> > - PXE booting x86 'headless' blades (2.0 Ghz 2P Xeon) to install RedHat 8.0 
> > (kernel 2.4.18).
> 
> Update the kernel once installed, the 2.4.18- kernels are obsoleted by
> other security fixes
> 
> > - the blade, after 3 seconds, starts a storm of retransmit (MOUNT reqs) that 
> > won't stop, unless an ACK (one of the several ACKS sent for each retransmitted 
> > requests) has the chance to get through. This is sometimes after a few hundreds 
> > packets, sometimes after a lot more, causing an apparent hang of the 
> > installation process, and what's even worse, bringing to a grinding halt the  
> > server (bombarded by near 1Gbit/sec packets).
> 
> I've seen one other report of this (with a via chip),

FWIW, on my Via EPIA (pre-Nehemiah C3) Wal-Mart box, I see NFS (?) bugs
as well.  I can mount just fine and do an 'ls' of a remote dir... but
any attempt to actually transfer data causes the entire mount to hang in
disk wait.

I swapped out NICs several times (and verified the NICs in other boxes)
but can reproduce this behavior quite easily.

ssh, ftp, and other services work flawlessly... it's just NFS.

I even tried tcp instead of udp, to no avail.

	Jeff, inevitably lacking time to track things down



