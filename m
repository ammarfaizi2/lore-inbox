Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265786AbTAJUvw>; Fri, 10 Jan 2003 15:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265885AbTAJUvw>; Fri, 10 Jan 2003 15:51:52 -0500
Received: from web20502.mail.yahoo.com ([216.136.226.137]:20002 "HELO
	web20502.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S265786AbTAJUvu>; Fri, 10 Jan 2003 15:51:50 -0500
Message-ID: <20030110210035.76482.qmail@web20502.mail.yahoo.com>
Date: Fri, 10 Jan 2003 13:00:35 -0800 (PST)
From: Manish Lachwani <m_lachwani@yahoo.com>
Subject: Using lilo to boot off any drive ...
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my current setup, I am having 12 ide drives
connected to a 3ware controller labelled sda to sdl.
Suppose sde is the drive we want the system to boot
off. What I do is modify the lilo.conf on sda, sdb,
sdc etc. to have the "boot" entry point to /dev/sde.

This way when the controller is transferred to lilo on
sda, it will load the kernel from sde. 

consider this. If sda is bad and is not exported to
the OS or is not detected in the BIOS due to a bad
cable etc. In this scenario, the OS mappings would
change. Now, sdb will become sda. The lilo.conf on sdb
(now sda) would have "boot" parameter still point to
sde, which is now sdd. 

When the control is transferred to lilo on sda (sdb
actually), is there a way for me to boot off sdd now
(which was previously sde)? I mean, is there any way
that lilo can load the appropriate kernel image?

One of the ways I was thinking of was to modify the
lilo sources to scan for drive serial# and we boot off
that drive for which the serial# matches. But, does
anyone have a better alternative?

Thanks
Manish

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
