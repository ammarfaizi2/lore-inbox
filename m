Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265526AbUABM7S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 07:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265528AbUABM7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 07:59:18 -0500
Received: from firewall.conet.cz ([213.175.54.250]:22427 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265526AbUABM7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 07:59:17 -0500
Message-ID: <3FF56B1C.1040308@conet.cz>
Date: Fri, 02 Jan 2004 13:59:08 +0100
From: Libor Vanek <libor@conet.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Syscall table AKA hijacking syscalls
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm writing some project which needs to hijack some syscalls in VFS 
layer. AFAIK in 2.6 is this "not-wanted" solution (even that there are 
some very nasty ways of doing it - see 
http://mail.nl.linux.org/kernelnewbies/2002-12/msg00266.html )

Also I've found out that Linus stated that intercepting syscalls is "bad 
thing" (load module a, load module b, unload module b => crash) but I 
think that there are some very good reasons (and ways) to do it (see 
http://syscalltrack.sourceforge.net ). My main reason to do it is that I 
want my GPLed module to be able to modify some VFS syscalls without 
patching and recompiling whole kernel and rebooting the machine.

So what is proper (Linus recommanded) way to do such a things? Create 
patches for specific syscalls like "if this_module_installed then 
call_this_function;" or try to force things like syscalltrack to go into 
vanilla kernel some time? Because what I've found out there are more 
projects which suffer from this restriction.


-- 

Libor Vanek






