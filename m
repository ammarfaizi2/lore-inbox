Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264254AbUEDUtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbUEDUtF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 16:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264282AbUEDUtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 16:49:04 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:30594 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S264254AbUEDUtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 16:49:01 -0400
Date: Tue, 4 May 2004 13:48:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix booting some PPC32 machines
Message-ID: <20040504204849.GA14974@smtp.west.cox.net>
References: <20040503180945.GL26773@smtp.west.cox.net> <20040504070606.GA11701@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040504070606.GA11701@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 09:06:06AM +0200, Olaf Hering wrote:
>  On Mon, May 03, Tom Rini wrote:
> 
> > Hello.  The following patch fixes booting on some PPC32 machines with
> > OpenFirmware, when booted without the aid of an additional bootloader.
> > The problem is that the linker script for the 'zImage' type targets was
> > put into the list of dependancies which objcopy would parse as a list of
> > files to copy into the resulting image.  The fix is to make the phony
> > zImage targets depend on the linker script.
> 
> This fixes netbooting on my B50. But it breaks the dependency to ld.script,
> which was the whole point of the previous patch.

As I mentioned on IRC, but don't have time ATM to verify, I don't think
a 'touch' of the ld.script is sufficient a test in this case since it's
a call-if-changed thing so you'd have to modify ld.script.  Can you do
that and see if it's really a change?  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
