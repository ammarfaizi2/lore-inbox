Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263432AbTDYQ3N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 12:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263459AbTDYQ3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 12:29:12 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:65161
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263432AbTDYQ3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 12:29:12 -0400
Subject: Re: problem with Serverworks CSB5 IDE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Duncan Laurie <duncan@sun.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EA964D1.3070908@sun.com>
References: <3EA85C5C.7060402@sun.com> <20030423212713.GD21689@puck.ch>
	 <1051136469.2062.108.camel@dhcp22.swansea.linux.org.uk>
	 <20030423232909.GE21689@puck.ch> <20030423232909.GE21689@puck.ch>
	 <20030424080023.GG21689@puck.ch> <3EA85C5C.7060402@sun.com>
	 <1051268422.5573.25.camel@dhcp22.swansea.linux.org.uk>
	 <3EA964D1.3070908@sun.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051285350.5902.14.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Apr 2003 16:42:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-04-25 at 17:39, Duncan Laurie wrote:
> mode because the PCI interrupt pin register is hardwired to zero (don't
> ask me why...) so it follows a codepath in do_ide_setup_pci_device()
> where init_chipset isn't called.

That would imply a problem in the PCI layer, since the IRQ should have 
been assigned, and if the IRQ is not assigned we can't use the device.

I'll take a look. 

