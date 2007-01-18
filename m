Return-Path: <linux-kernel-owner+w=401wt.eu-S1752035AbXAROOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbXAROOM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 09:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752036AbXAROOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 09:14:12 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2732 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbXAROOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 09:14:11 -0500
Date: Thu, 18 Jan 2007 14:14:00 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Bernhard Walle <bwalle@suse.de>
Cc: linux-kernel@vger.kernel.org, Alon Bar-Lev <alon.barlev@gmail.com>
Subject: Re: [patch 03/26] Dynamic kernel command-line - arm
Message-ID: <20070118141359.GB31418@flint.arm.linux.org.uk>
Mail-Followup-To: Bernhard Walle <bwalle@suse.de>,
	linux-kernel@vger.kernel.org, Alon Bar-Lev <alon.barlev@gmail.com>
References: <20070118125849.441998000@strauss.suse.de> <20070118130028.719472000@strauss.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070118130028.719472000@strauss.suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 01:58:52PM +0100, Bernhard Walle wrote:
> 2. Set command_line as __initdata.

You can't.

> -static char command_line[COMMAND_LINE_SIZE];
> +static char __initdata command_line[COMMAND_LINE_SIZE];

Uninitialised data is placed in the BSS.  Adding __initdata to BSS
data causes grief.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
