Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUHNSWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUHNSWW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 14:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUHNSWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 14:22:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:8145 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264396AbUHNSWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 14:22:19 -0400
Date: Sat, 14 Aug 2004 11:12:07 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: zippel@linux-m68k.org, sam@ravnborg.org, bunk@fs.tum.de,
       linux-kernel@vger.kernel.org
Subject: Re: menuconfig displays dependencies [Was: select FW_LOADER ->
 depends HOTPLUG]
Message-Id: <20040814111207.08c96a53.rddunlap@osdl.org>
In-Reply-To: <20040814074953.GA20123@mars.ravnborg.org>
References: <20040809195656.GX26174@fs.tum.de>
	<20040809203840.GB19748@mars.ravnborg.org>
	<Pine.LNX.4.58.0408100130470.20634@scrub.home>
	<20040810084411.GI26174@fs.tum.de>
	<20040810211656.GA7221@mars.ravnborg.org>
	<Pine.LNX.4.58.0408120027330.20634@scrub.home>
	<20040814074953.GA20123@mars.ravnborg.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Aug 2004 09:49:53 +0200 Sam Ravnborg wrote:

| On Thu, Aug 12, 2004 at 01:05:47AM +0200, Roman Zippel wrote:
|  
| > > It would be nice in menuconfig to see what config symbol
| > > that has dependencies and/or side effects. 
| > 
| > xconfig has something like this, if you enable 'Debug Info', although it 
| > rather dumps the internal representation.
| > Adding something like this to menuconfig, would mean hacking lxdialog, 
| > which is rather at the bottom of the list of things I want to do. :)
| 
| Did a quick hack on this.
| When choosing help on "HCI BlueFRITZ! USB driver" menuconfig now displays:
| 
| -------------------------------------------------
| Depends on (select to enable this option):
| BT & USB
| Selects (will be enabled by this option): 
| FW_LOADER
| 
| CONFIG_BT_HCIBFUSB
| 
| Bluetooth HCI BlueFRITZ! USB driver.
| ....
| -------------------------------------------------
| 
| To simplify things I just malloc'ed 'enough' memory for the help screen.
| Just a quick hack, but something to play with - and no lxdialog hacking :-)

Hi Sam,
I started on this yesterday also, but you are ahead of me.

Looking pretty good, but for menu items in the EMBEDDED menu,
it misses entries like this one:

config FUTEX
	bool "Enable futex support" if EMBEDDED

It doesn't list any Depends data, but it actually depends on EMBEDDED.

I'll look at it more later.  Got other stuff to do now.

--
~Randy
