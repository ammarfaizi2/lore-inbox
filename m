Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265698AbUAJXmz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 18:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265699AbUAJXmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 18:42:55 -0500
Received: from [66.62.77.7] ([66.62.77.7]:31913 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S265698AbUAJXmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 18:42:54 -0500
Subject: Re: Do not use synaptics extensions by default
From: Dax Kelson <dax@gurulabs.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20040110195531.GD22654@ucw.cz>
References: <20040110175930.GA1749@elf.ucw.cz>
	 <20040110193039.GA22654@ucw.cz> <20040110194420.GA1212@elf.ucw.cz>
	 <20040110195531.GD22654@ucw.cz>
Content-Type: text/plain
Message-Id: <1073778167.7644.4.camel@mentor.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 10 Jan 2004 16:42:48 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-01-10 at 12:55, Vojtech Pavlik wrote:
> Or, the very nice thing to do would be to port the XFree86 driver to
> GPM, so that GPM can understand the event protocol as well.

Already done...

# rpm -q gpm
gpm-1.20.1-dt8

# ps -e o pid,user,cmd | grep gpm
 2068 root     gpm -m /dev/input/event0 -t evdev -o type=synaptics -M -m /dev/input/mice -t imps2

I believe the issue is that /dev/input/event0 can't be opened by
multiple things (gpm and X) in 2.4 as can be done in 2.6.

Dax Kelson
Guru Labs

