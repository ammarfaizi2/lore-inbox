Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWAEX4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWAEX4U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWAEX4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:56:20 -0500
Received: from isilmar.linta.de ([213.239.214.66]:3772 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932087AbWAEX4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:56:20 -0500
Date: Fri, 6 Jan 2006 00:56:18 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: alan <alan@clueserver.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with pci_fixups in drivers/pci/probe.c
Message-ID: <20060105235618.GA317@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	alan <alan@clueserver.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0601051533430.27220-100000@www.fnordora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0601051533430.27220-100000@www.fnordora.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 05, 2006 at 03:46:35PM -0800, alan wrote:
> I went to patch the current FC5T1 kernel and found that the patch no 
> longer applied.  On further investigation I found that the patch had been 
> added to the kernel, but some helpful soul had added a subroutine that 
> made it absolutely worthless to anyone on x86 architecture.

See
http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=12f44f46bc9c6dc79255e661b085797af395d8da
and
http://bugzilla.kernel.org/show_bug.cgi?id=5557
for more information on this issue.

> My cardbus devices will thank you.

Well, you can add "pci=assign-busses" as boot parameter, and then the
cardbus devices should work. Alternatively, I'd propose making
pcibios_assign_all_busses default to 1 on x86-64 (at least), possibly also on
x86.

	Dominik
