Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbTCBVJy>; Sun, 2 Mar 2003 16:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267084AbTCBVJy>; Sun, 2 Mar 2003 16:09:54 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:41369
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265667AbTCBVJx>; Sun, 2 Mar 2003 16:09:53 -0500
Subject: Re: S4bios support for 2.5.63
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: bert hubert <ahu@ds9a.nl>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>, Pavel Machek <pavel@ucw.cz>,
       Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030302202118.GA2201@outpost.ds9a.nl>
References: <20030226211347.GA14903@elf.ucw.cz>
	 <20030302133138.GA27031@outpost.ds9a.nl>
	 <1046630641.3610.13.camel@laptop-linux.cunninghams>
	 <20030302202118.GA2201@outpost.ds9a.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046643757.3700.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 02 Mar 2003 22:22:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-02 at 20:21, bert hubert wrote:
> On Mon, Mar 03, 2003 at 07:44:03AM +1300, Nigel Cunningham wrote:
> > Hi.
> > 
> > This bug is fixed in Linus tree. If you want swsusp to work in the mean
> > time, look for a couple of patches Pavel sent recently.
> 
> Ok,
> 
> In 2.5.63bk5 I get a BUG on drivers/ide/ide-disk.c:1557:
> 
> 
>         BUG_ON (HWGROUP(drive)->handler);

Looks like swsuspend attempted to run an operation while one was in
progress. IDE tries to catch that because the result of missing it isnt
very pretty at fsck time.


