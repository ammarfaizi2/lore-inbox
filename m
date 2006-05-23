Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWEWRsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWEWRsk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 13:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWEWRsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 13:48:40 -0400
Received: from terminus.zytor.com ([192.83.249.54]:41345 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751139AbWEWRsj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 13:48:39 -0400
Message-ID: <44734AEF.2020104@zytor.com>
Date: Tue, 23 May 2006 10:48:31 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [-mm] klibc breaks my initscripts
References: <20060523083754.GA1586@elf.ucw.cz>
In-Reply-To: <20060523083754.GA1586@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> To reproduce: boot with init=/bin/bash
> 
> attempt to
> 
> mount / -oremount,rw
> 
> I have this as my command line:
> 
> root=/dev/hda4 resume=/dev/hda1 psmouse.psmouse_proto=imps
> psmouse_proto=imps psmouse.proto=imps vga=1 pci=assign-busses
> rootfstype=ext2
> 

I tried this (or at least as close to this as I can get in my simulation 
environment), and I don't see any problems.  It works as is should; 
however, mount(8) requires that /proc is mounted so that it can read 
/proc/partitions, but that has nothing to do with klibc (or the kernel 
overall) of course.

I'm afraid I'm going to have to ask for more details...

	-hpa
