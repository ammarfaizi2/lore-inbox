Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264811AbTFBRiA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 13:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264812AbTFBRiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 13:38:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28434 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264811AbTFBRh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 13:37:59 -0400
Date: Mon, 2 Jun 2003 18:51:18 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Paul Rolland <rol@as2917.net>
Cc: "'Ruud Linders'" <rkmp@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: Serial port numbering (ttyS..) wrong for 2.5.61+
Message-ID: <20030602185118.B776@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Rolland <rol@as2917.net>,
	'Ruud Linders' <rkmp@xs4all.nl>, linux-kernel@vger.kernel.org
References: <3ED9E025.1060801@xs4all.nl> <015a01c3283c$11642370$2101a8c0@witbe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <015a01c3283c$11642370$2101a8c0@witbe>; from rol@as2917.net on Sun, Jun 01, 2003 at 02:48:14PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 01, 2003 at 02:48:14PM +0200, Paul Rolland wrote:
> Numbering seems to be coming out of 
> drivers/serial/core.c : uart_find_match_or_unused
> which is responsible for finding an unused state for the port.
> 
> However, the code there seems to be clean and I guess we should look
> where the state are initialized.

When we add a port to the system, we try to find in order:

- a port which matches the base address
- a port which is unallocated

Probably the easiest way to stop the "ttyS14" occuring would be to
clear the port information at boot when we don't find a port.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

