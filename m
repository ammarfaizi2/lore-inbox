Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVCGJWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVCGJWP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 04:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVCGJWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 04:22:15 -0500
Received: from orb.pobox.com ([207.8.226.5]:57232 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261720AbVCGJWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 04:22:12 -0500
Date: Mon, 7 Mar 2005 01:22:06 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Stefan Seyfried <seife@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       barryn@pobox.com, Pavel Machek <pavel@ucw.cz>
Subject: Re: [Bug 4298] swsusp fails to suspend if CONFIG_DEBUG_PAGEALLOC is   also enabled
Message-ID: <20050307092206.GB5083@ip68-4-98-123.oc.oc.cox.net>
References: <20050306030852.23eb59db.akpm@osdl.org> <20050306225730.GA1414@elf.ucw.cz> <20050306195954.6d13cff9.akpm@osdl.org> <422C0A6B.1060700@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422C0A6B.1060700@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 09:01:47AM +0100, Stefan Seyfried wrote:
> Andrew Morton wrote:
[snip]
> > Isn't some Kconfig solution appropriate here?
> 
> Yes, but only for the CONFIG_DEBUG_PAGEALLOC case, it does not solve the
> "cpu has no PSE" case for VIA CPUs. So the Kconfig solution is an extra
> bonus.

Note that I've posted a Kconfig solution here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=111017249931972&w=2

Regarding Pavel's patch, it seems to me that it might be better to print
the message at boot time, instead of (or in addition to?) his patch.
Maybe we should be disabling swsusp altogether at boot in that case, if
that's not unreasonably hard to implement.

-Barry K. Nathan <barryn@pobox.com>
