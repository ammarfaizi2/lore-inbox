Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937108AbWLFS5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937108AbWLFS5G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 13:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937121AbWLFS5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 13:57:06 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:54126 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937108AbWLFS5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 13:57:02 -0500
Date: Wed, 6 Dec 2006 10:57:24 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: James Simmons <jsimmons@infradead.org>
Cc: Miguel Ojeda <maxextreme@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Luming Yu <Luming.yu@intel.com>, Andrew Zabolotny <zap@homelink.ru>,
       linux-acpi@vger.kernel.org, kernel-discuss@handhelds.org
Subject: Re: Display class
Message-Id: <20061206105724.cf7b39bc.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.64.0612061818540.28745@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org>
	<653402b90611141426y6db15a3bh8ea59f89c8f1bb39@mail.gmail.com>
	<Pine.LNX.4.64.0611150052180.13800@pentafluge.infradead.org>
	<Pine.LNX.4.64.0612051740250.2925@pentafluge.infradead.org>
	<20061205171401.fd11160d.randy.dunlap@oracle.com>
	<Pine.LNX.4.64.0612061443180.28745@pentafluge.infradead.org>
	<20061206101434.8acb229a.randy.dunlap@oracle.com>
	<Pine.LNX.4.64.0612061818540.28745@pentafluge.infradead.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006 18:24:08 +0000 (GMT) James Simmons wrote:

> 
> > > That patch was rought draft for feedback. I applied your comments. This 
> > > patch actually works. It includes my backlight fix as well.
> > 
> > Glad to hear it.  I had to make the following changes
> > in order for it to build.
> > However, I still have build errors for aty.
> 
> Ug. I see another problem. I had backlight completly compiled as a 
> module! Thus it hid these compile errors. So we need also a 
> CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE check as well. Can sysfs handle this 
> well or would it be better the the backlight class be a boolean instead?

SCSI works as a module and it uses sysfs.
See drivers/scsi/scsi_sysfs.c.
Does that answer your question?  I wasn't quite sure what
the question was.

Next question, based on:
drivers/built-in.o: In function `probe_edid':
(.text.probe_edid+0x42): undefined reference to `fb_edid_to_monspecs'

Should backlight and/or display support depend on
CONFIG_FB?  Right now they don't, so the above can happen...

---
~Randy
