Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424286AbWLBSCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424286AbWLBSCq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 13:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424309AbWLBSCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 13:02:46 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:27667 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1424286AbWLBSCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 13:02:46 -0500
Date: Sat, 2 Dec 2006 18:02:33 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] cleanup asm/setup.h userspace visibility
Message-ID: <20061202180233.GA26111@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20061202175539.GV11084@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061202175539.GV11084@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2006 at 06:55:39PM +0100, Adrian Bunk wrote:
> This patch makes the contents of the userspace asm/setup.h header 
> consistent on all architectures:
> - export setup.h to userspace on all architectures
> - export only COMMAND_LINE_SIZE to userspace

On ARM, all the ATAGs are exported to userspace because they are an API
for boot loaders to use.  Everything down to the comment "Memory map
description" should be exported.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
