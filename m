Return-Path: <linux-kernel-owner+w=401wt.eu-S1752651AbWLVVpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbWLVVpO (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 16:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752879AbWLVVpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 16:45:14 -0500
Received: from styx.suse.cz ([82.119.242.94]:55023 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750997AbWLVVpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 16:45:13 -0500
Date: Fri, 22 Dec 2006 22:42:38 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] Fix some ARM builds due to HID brokenness
In-Reply-To: <20061222170916.GA3320@dyn-67.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612222237320.11292@jikos.suse.cz>
References: <20061222170916.GA3320@dyn-67.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2006, Russell King wrote:

> The new location for HID is extremely annoying:

Hi Russell,

well, the location itself was a subject to various discussions. At the 
end, drivers/hid won against drivers/input/hid, because, as Marcel 
correctly pointed out, in case of embedded systems there might be a need 
to have an abstraction for non-input devices and then we don't want to 
bundle it to tightly to input. There is no such implementation yet, but 
moving this code around is quite painful, so we don't want to do it more 
than once.

> 1. the help text implies that you need to enable it for any
>    keyboard or mouse attached to the system.  This is not
>    correct.

This help text has been there for ages, it was duplicated from previous 
help text from usb hid implementation, but you are right that the wording 
might confuse someone. Will change it eventually, thanks.

> 2. it defaults to 'y'.  When you have input deselected, this
>    causes the kernel to fail to link:
> Fix the second problem by making it depend on INPUT.
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
