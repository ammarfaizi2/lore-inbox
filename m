Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbUEHLKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUEHLKD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 07:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbUEHLKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 07:10:03 -0400
Received: from ns.suse.de ([195.135.220.2]:61112 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261907AbUEHLKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 07:10:00 -0400
Date: Sat, 8 May 2004 13:09:59 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how long does it take to init the scheduler?
Message-ID: <20040508110959.GA1374@suse.de>
References: <20040508105311.GA15577@suse.de> <20040508035934.46101a9b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040508035934.46101a9b.akpm@osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, May 08, Andrew Morton wrote:

> Olaf Hering <olh@suse.de> wrote:
> >
> > 
> > Hi,
> > 
> > the patch below looks wrong to me. Why did you move it to the very end
> > of the boot process, instead to the very end of start_kernel()?
> > 
> 
> coz I forgot about drivers which want to go opening files in their
> module_init().
> 
> Like this?

Yes, but I cant verify it before Monday.

That leads to another question. usermodehelper_init() is now an initcall.
all the binfmt stuff is also an initcall. We had a patch (for debugging)
that turned init_elf_binfmt() into core_initcall.
Can we change that as well, so one could finally run stuff via the
driver hotplug events? init_script_binfmt() should be also
core_initcall, so you can run scripts. But I havent looked at the
dependencies for the binfmt stuff.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
