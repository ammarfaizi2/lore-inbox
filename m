Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVCSVIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVCSVIU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 16:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVCSVIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 16:08:20 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:52427 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261800AbVCSVIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 16:08:18 -0500
Date: Sat, 19 Mar 2005 22:08:13 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Karim Yaghmour <karim@opersys.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Relayfs question
In-Reply-To: <423C913B.6000307@opersys.com>
Message-ID: <Pine.LNX.4.61.0503192155240.6141@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0503191852520.21324@yvahk01.tjqt.qr>
 <423C78E8.3040200@ev-en.org> <Pine.LNX.4.61.0503192014520.14144@yvahk01.tjqt.qr>
 <423C913B.6000307@opersys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Ok, urandom was a bad example. I have my tty logger (ttyrpld.sf.net) which 
>> moves a lot of data (depends) to userspace. It uses a ring buffer [...]
>[...]
>Basically, all the transport code you are doing in the kernel side of
>your logger would be taken care of by relayfs. And given that there are
>a lot of people doing similar ad-hoc buffering code, it just makes
>sense to have one well-tested yet generic mechanism. Have a look at
>Documentation/filesystems/relayfs.txt for the API details.

Well, what about things like urandom? It also moves "a lot" of data and does
nothing else.

>[...]
>Just to avoid any confusion, note that I'm referring mainly to rpldev.c,
>which is the kernel-side driver for the logger, I haven't looked at any
>of the user tools.

The userspace daemon just read()s the device and analyzes it. Nothing to
optimize there, with respect to relayfs, I think.



Jan Engelhardt
-- 
