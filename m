Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265002AbTFLVaa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 17:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265004AbTFLVaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 17:30:30 -0400
Received: from ip68-107-142-198.tc.ph.cox.net ([68.107.142.198]:57232 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP id S265002AbTFLVa1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 17:30:27 -0400
Date: Thu, 12 Jun 2003 14:44:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: [PATCH] early_port_register
Message-ID: <20030612214411.GK828@ip68-0-152-218.tc.ph.cox.net>
References: <20030612132001.A4693@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612132001.A4693@home.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 01:20:01PM -0700, Matt Porter wrote:

> This has been discussed in a previous thread originated by David
> Mosberger.  This removed early_serial_setup() in favor of  a
> working early_port_register() call.  Many PPC systems rely on
> this functionality and are currently hacking around it in the
> PPC devel tree.  Last I looked, IA64 still had this in their
> devel tree too.

I'm not sure if this is related to recent TTY changes or not, but this
does bring up a small 'issue'.  To get at uart_port, you need
<linux/serial_core.h>, which currently requires but does not #include
<linux/tty.h>.  But I haven't been following close enough to know if
this is new breakage due to TTY changes or just no one had done
linux/serial_core.h w/o linux/tty.h before..

-- 
Tom Rini
http://gate.crashing.org/~trini/
