Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbUJZJV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbUJZJV0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 05:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbUJZJV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 05:21:26 -0400
Received: from gprs214-185.eurotel.cz ([160.218.214.185]:45954 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262182AbUJZJVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 05:21:19 -0400
Date: Tue, 26 Oct 2004 11:21:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Li Shaohua <shaohua.li@intel.com>
Cc: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>,
       greg@kroah.com
Subject: Re: [Proposal]Another way to save/restore PCI config space for suspend/resume
Message-ID: <20041026092106.GC28897@elf.ucw.cz>
References: <1098766257.8433.7.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098766257.8433.7.camel@sli10-desk.sh.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> We suffer from PCI config space issue for a long time, which causes many
> system can't correctly resume. Current Linux mechanism isn't sufficient.
> Here is a another idea: 
> Record all PCI writes in Linux kernel, and redo all the write after
> resume in order. The idea assumes Firmware will restore all PCI config
> space to the boot time state, which is true at least for IA32.

That looks extremely ugly to me. If you want to do something special
in resume function, just do it there. It will probably share a lot of
code with your init function, anyway.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
