Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270501AbTG1T46 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 15:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270505AbTG1T46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 15:56:58 -0400
Received: from chaos.analogic.com ([204.178.40.224]:45447 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S270501AbTG1T4z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 15:56:55 -0400
Date: Mon, 28 Jul 2003 16:00:03 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Turning off automatic screen clanking
Message-ID: <Pine.LNX.4.53.0307281555400.27569@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have experimentally determined that I can turn off
the automatic screen blanking with the following escape
sequence.

const char blk[]={27, '[', '9', ';', '0', ']', 0};
main()
{
    printf(blk);
}

I need to know what the appropriate ioctl() is to do this
directly without using escape sequences. I have searched
the 2.4.20 sources and can't find any documentation for
anything that remotely even looks like it turns off the
automatic blanking. The code appears to be truly magic.

This is important for some imbeded systems because there
isn't any input available, and the screen output gets shut
off and can't be turned on except by re-booting.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

