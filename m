Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbTKIMMq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 07:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbTKIMMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 07:12:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62480 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262458AbTKIMMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 07:12:44 -0500
Date: Sun, 9 Nov 2003 12:12:41 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: crashme on ARM - unkillable processes
Message-ID: <20031109121241.B29553@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20031109114322.A29553@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031109114322.A29553@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Nov 09, 2003 at 11:43:22AM +0000
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 09, 2003 at 11:43:22AM +0000, Russell King wrote:
> Subprocess 2: Barfed
> Subprocess 2: try 22, offset 88
> time limit reached on pid 1704 0x6A8. using kill.
> 
> At this point, PID1704 refuses to die.
> 
> Looking at the output of sysrq-p and sysrq-t, it would appear that the
> subprocess is receiving SIGILL after SIGILL after SIGILL, virtually
> continuously.

A little more information:

After trying to send SIGINT and SIGHUP, as well as SIGKILL,
/proc/*/status contains the following:

SigPnd: 0000000000000408
ShdPnd: 0000000000006103
SigBlk: 0000000000000000
SigIgn: 0000000000000000
SigCgt: 00000000000020fa

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
