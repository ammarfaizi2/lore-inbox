Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264880AbTIDJxI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 05:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264900AbTIDJxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 05:53:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3086 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264880AbTIDJxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 05:53:01 -0400
Date: Thu, 4 Sep 2003 10:52:57 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: =?iso-8859-1?Q?Laurent_Hug=E9?= <laurent.huge@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Call of tty->driver.write provides segmentation fault
Message-ID: <20030904105257.B7387@flint.arm.linux.org.uk>
Mail-Followup-To: =?iso-8859-1?Q?Laurent_Hug=E9?= <laurent.huge@wanadoo.fr>,
	linux-kernel@vger.kernel.org
References: <200309041107.12393.laurent.huge@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200309041107.12393.laurent.huge@wanadoo.fr>; from laurent.huge@wanadoo.fr on Thu, Sep 04, 2003 at 11:07:11AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 11:07:11AM +0200, Laurent Hugé wrote:
> I'm currently contriving a network driver using the serial port.
> I've created my own line discipline (and tests prove it reads well), but I
> can't write to the port : I tried to use tty->driver.write(tty, 0, msg,
> strlen(msg)) (the same way that in printk.c, i.e. after testing that
> tty->driver.write exists) but it crashs into a segmentation fault.
> Since the driver implementation is not mine (I'm just using the serial
> module), I can't check the function's address, but I believe the tty is
> ok (it is the same I use for the line discipline).

You need to look at the kernel messages - normally you'll find an
"oops" in there when this happens.  If the dump doesn't contain
symbolic information (ie, the function names) you'll need to pass
it though ksymoops to decode it (using the correct System.map file
for the kernel which generated the dump.)

If you do use ksymoops, be sure to include the original oops dump -
ksymoops appears to drop some lines from the oops dump.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

