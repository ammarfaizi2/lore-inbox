Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTG1L2I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 07:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTG1L1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 07:27:52 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:13961
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263930AbTG1L1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 07:27:23 -0400
Subject: Re: [PATCH] Remove module reference counting.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Nottingham <notting@redhat.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@osdl.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@redhat.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030727201242.A29448@devserv.devel.redhat.com>
References: <Pine.LNX.4.44.0307261230110.1841-100000@home.osdl.org>
	 <20030727193919.832302C450@lists.samba.org>
	 <20030727214701.A23137@devserv.devel.redhat.com>
	 <20030727201242.A29448@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059392321.15458.23.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Jul 2003 12:38:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-28 at 01:12, Bill Nottingham wrote:
> It loads/unloads things like scsi modules and firewire controller
> modules, but only for hardware actually present in the system (i.e.,
> you'd probably be loading it again anyway, if you haven't already
> loaded it.)

It loads things like floppy anyway, and it loads lots of things like the
firewire stuff that nobody ever uses because it has to see if anything
is plugged into them.

I guess kudzu could simply do lots of I/O ops directly on the floppy 
hardware to detect it without loading drivers but thats pretty fugly.

