Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269160AbUIHOOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269160AbUIHOOS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 10:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267928AbUIHOHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 10:07:21 -0400
Received: from cantor.suse.de ([195.135.220.2]:55681 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269168AbUIHODX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 10:03:23 -0400
Date: Wed, 8 Sep 2004 16:03:23 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_CMDLINE broken on ppc
Message-ID: <20040908140323.GA15309@suse.de>
References: <20040908134028.GB15209@suse.de> <20040908135211.GA26381@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040908135211.GA26381@smtp.west.cox.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Sep 08, Tom Rini wrote:

> On Wed, Sep 08, 2004 at 03:40:28PM +0200, Olaf Hering wrote:
> 
> > CONFIG_CMDLINE can not work on ppc.
> > machine_init() copies the string to cmd_line, then platform_init() is
> > called. It truncates the string to length zero.
> 
> This has come up before, actually.  What happens if CMDLINE isn't set,
> and we don't terminate cmd_line here?  It's part of the BSS and is
> zero'd out anyways?

strlcpy generates a null-terminated string, if size != 0. Looks like
that line can go. Or move it at the start of machine_init().

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
