Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbTK2GZp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 01:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbTK2GZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 01:25:45 -0500
Received: from gw-undead3.tht.net ([216.126.84.18]:45696 "HELO mail.undead.cc")
	by vger.kernel.org with SMTP id S263695AbTK2GZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 01:25:44 -0500
Message-ID: <3FC83BE1.5010307@undead.cc>
Date: Sat, 29 Nov 2003 01:25:37 -0500
From: John Zielinski <grim@undead.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: Rootfs mounted from user space - problem with umount
References: <3FC82D8F.9030100@undead.cc> <200311290538.hAT5c702013700@turing-police.cc.vt.edu>
In-Reply-To: <200311290538.hAT5c702013700@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

>I'm missing something - why not use an initrd and pivot_root and then
>unmount the old root?  Seems to work here.
>  
>

I'm using the 2.6.0-test9 kernel and initramfs to store video mode data 
that my kernel mods will read during boot.  Using cpio is a lot easier 
than making a file system using the loopback device.   I want to keep 
the rootfs around since I can modify it and then cpio it back up in a 
shutdown script for next boot.

If I used initrd I'd also have to set up a usable filesystem.  This way 
I can just have data in there.

John




