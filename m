Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274977AbTHFJXF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 05:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274985AbTHFJXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 05:23:05 -0400
Received: from mail.cybertrails.com ([162.42.150.35]:56591 "EHLO
	mail2.cybertrails.com") by vger.kernel.org with ESMTP
	id S274977AbTHFJXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 05:23:02 -0400
Date: Wed, 6 Aug 2003 02:22:56 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: My report on running 2.6.0-test2 on a Dell Inspiron 7000
 (possible tty trouble)
Message-Id: <20030806022256.4b4f967c.dickson@permanentmail.com>
In-Reply-To: <20030806021621.2da5a850.dickson@permanentmail.com>
References: <20030806021621.2da5a850.dickson@permanentmail.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Aug 2003 02:16:21 -0700, Paul Dickson wrote:

> But all is not perfect.  I'll attach the problems I had as replies (so
> each has it's own message thread).

I built 2.6.0-test2 for my Dell Inspiron 7000 notebook (PII, 300Mhz) with
a RH9 distribution.  I build the kernel on another system (1.33GHz) using
ssh.

I was missing some device support, so did a "make menuconfig".  The
configuration options were shown, I selected "Sound -->" and pressed
enter.  The terminal went back to text mode and then hung.  Gnome-terminal
started consuming all unused CPU cycles.  

I could recover the process by closing the tab or resetting the terminal,
but this would only fix the problem for the moment.  Frequently, it
wouldn't even finish redisplaying the screen before it locked again.

This would happen running "make menuconfig" locally or via ssh on another
system.

This is likely caused by some difference in the tty code in 2.6.0-test2.
The problem does not occur under 2.4.20-18.9.  If 2.6.0-test2 is correct,
then I might need an updated version of gnome-terminal suitable for 2.6.0.

	-Paul

