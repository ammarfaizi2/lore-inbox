Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbUJ0A6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbUJ0A6Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 20:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbUJ0A6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 20:58:15 -0400
Received: from fmr05.intel.com ([134.134.136.6]:4279 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S261559AbUJ0A5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 20:57:55 -0400
Subject: Re: [ACPI] Re: [Proposal]Another way to save/restore PCI config
	space for suspend/resume
From: Li Shaohua <shaohua.li@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>,
       greg@kroah.com
In-Reply-To: <20041026092106.GC28897@elf.ucw.cz>
References: <1098766257.8433.7.camel@sli10-desk.sh.intel.com>
	 <20041026092106.GC28897@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1098838245.12245.4.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 27 Oct 2004 08:50:46 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-26 at 17:21, Pavel Machek wrote:
> Hi!
> 
> > We suffer from PCI config space issue for a long time, which causes many
> > system can't correctly resume. Current Linux mechanism isn't sufficient.
> > Here is a another idea: 
> > Record all PCI writes in Linux kernel, and redo all the write after
> > resume in order. The idea assumes Firmware will restore all PCI config
> > space to the boot time state, which is true at least for IA32.
> 
> That looks extremely ugly to me. If you want to do something special
> in resume function, just do it there. It will probably share a lot of
> code with your init function, anyway.
How can you handle devices without driver? And how to save/restore
config space for special devices, such as LPC bridge and host bridge?

-Shaohua

