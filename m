Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267815AbUIHN4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267815AbUIHN4V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 09:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269157AbUIHNxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:53:15 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:38807 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S267703AbUIHNwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:52:21 -0400
Date: Wed, 8 Sep 2004 06:52:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_CMDLINE broken on ppc
Message-ID: <20040908135211.GA26381@smtp.west.cox.net>
References: <20040908134028.GB15209@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908134028.GB15209@suse.de>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 03:40:28PM +0200, Olaf Hering wrote:

> CONFIG_CMDLINE can not work on ppc.
> machine_init() copies the string to cmd_line, then platform_init() is
> called. It truncates the string to length zero.

This has come up before, actually.  What happens if CMDLINE isn't set,
and we don't terminate cmd_line here?  It's part of the BSS and is
zero'd out anyways?

-- 
Tom Rini
http://gate.crashing.org/~trini/
