Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271026AbTG1UXC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271030AbTG1UWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:22:55 -0400
Received: from chaos.analogic.com ([204.178.40.224]:50055 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S270810AbTG1UWo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:22:44 -0400
Date: Mon, 28 Jul 2003 16:25:48 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Frank v Waveren <fvw@var.cx>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off automatic screen clanking
In-Reply-To: <1059422724VQM.fvw@tracks.var.cx>
Message-ID: <Pine.LNX.4.53.0307281619060.27642@chaos>
References: <Pine.LNX.4.53.0307281555400.27569@chaos> <1059422724VQM.fvw@tracks.var.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003, Frank v Waveren wrote:

> On Mon, Jul 28, 2003 at 04:00:03PM -0400, Richard B. Johnson wrote:
> > I have experimentally determined that I can turn off
> > the automatic screen blanking with the following escape
> > sequence.
> I'm not aware of an ioctl for this, however experimental determination
> is hardly necessary, see setterm (specificly the -blank bit).
>

`setterm` sends escape-sequences to the terminal as well as using
ioctl(1, TCGETS) and TCSETS ioctl() calls. These ioctls() deal
with the termios structure which was no documented provision for
dealing with screen blanking. And, the experimental work involved
finding out what escape sequences were being sent to the terminal
since there is no known documentation of this specific method of
controlling the virtual terminal.

It is impossible to send escape sequences to an input that does
not exist. That's why I need to know how to stop the kernel's
insistence on turning off the screen.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

