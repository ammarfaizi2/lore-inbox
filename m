Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263220AbVGOFZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263220AbVGOFZa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 01:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263216AbVGOFZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 01:25:29 -0400
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:53411 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S263220AbVGOFYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 01:24:52 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Haninger <ahaning@gmail.com>
Subject: Re: PS/2 Keyboard is dead after resume.
Date: Fri, 15 Jul 2005 00:24:45 -0500
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org,
       suspend2-users <suspend2-users@lists.suspend2.net>
References: <105c793f0507141935403fc828@mail.gmail.com>
In-Reply-To: <105c793f0507141935403fc828@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507150024.46293.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 July 2005 21:35, Andrew Haninger wrote:
> Hello.
> 
> I'm using Linux Kernel 2.6.12.2 plus suspend 2.1.9.9 and acpi-20050408
> with the hibernate-1.10 script. My machine is a Shuttle SK43G which
> has a VIA KM400 chipset with an Athlon XP CPU.
> 
> Suspension seems to work well. However, when I resume, the keyboard is
> dead and there is a warning in dmesg before and after suspension:
> 
> atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86,
> might be trying access hardware directly.

Could you try doing:

	echo 1 > /sys/modules/i8042/parameters/debug

before suspending and the post your dmesg, please? Maybe we see something
there.

-- 
Dmitry
