Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265695AbUADPem (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 10:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265699AbUADPem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 10:34:42 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56335 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265695AbUADPel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 10:34:41 -0500
Date: Sun, 4 Jan 2004 15:34:38 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Mr Amit Mehrotra <mehrotraamit@yahoo.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: PCMCIA in 2.6.0 and 2.4.23 not detecting card inserts.
Message-ID: <20040104153438.B22480@flint.arm.linux.org.uk>
Mail-Followup-To: Mr Amit Mehrotra <mehrotraamit@yahoo.co.in>,
	linux-kernel@vger.kernel.org
References: <20040104143755.6022.qmail@web8203.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040104143755.6022.qmail@web8203.mail.in.yahoo.com>; from mehrotraamit@yahoo.co.in on Sun, Jan 04, 2004 at 02:37:55PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 02:37:55PM +0000, Mr Amit Mehrotra wrote:
> Kernel command line: root=/dev/hda5 ro mem=1048512K
                                         ^^^^^^^^^^^^

actually, I think this is your problem - you're overriding the E820
memory map, and telling the kernel that anything above 1048512K is
available for use.  Plainly this is not the case.

Please try booting without this argument.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
