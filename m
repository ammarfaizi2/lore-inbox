Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264255AbUEDHGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbUEDHGf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 03:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbUEDHGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 03:06:35 -0400
Received: from ns.suse.de ([195.135.220.2]:26796 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264257AbUEDHGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 03:06:07 -0400
Date: Tue, 4 May 2004 09:06:06 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix booting some PPC32 machines
Message-ID: <20040504070606.GA11701@suse.de>
References: <20040503180945.GL26773@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040503180945.GL26773@smtp.west.cox.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, May 03, Tom Rini wrote:

> Hello.  The following patch fixes booting on some PPC32 machines with
> OpenFirmware, when booted without the aid of an additional bootloader.
> The problem is that the linker script for the 'zImage' type targets was
> put into the list of dependancies which objcopy would parse as a list of
> files to copy into the resulting image.  The fix is to make the phony
> zImage targets depend on the linker script.

This fixes netbooting on my B50. But it breaks the dependency to ld.script,
which was the whole point of the previous patch.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
