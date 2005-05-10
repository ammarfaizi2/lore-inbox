Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVEJEyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVEJEyd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 00:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVEJEyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 00:54:33 -0400
Received: from mail.mystique-magazine.com ([205.238.173.42]:22252 "HELO
	mail.mystique-magazine.com") by vger.kernel.org with SMTP
	id S261549AbVEJEyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 00:54:31 -0400
Message-ID: <42803E86.5060107@infinity-studios.com>
Date: Mon, 09 May 2005 23:54:30 -0500
From: Dzuy Nguyen <dzuy@infinity-studios.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Strange 2.6 initrd/initramfs problem with shared libraries on VIA
 C3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure if this is a bug or whether it's been addressed, but I'm
seeing a strange problem with 2.6 kernel on my VI C3 boards.

I replace nash on FC3's initramfs with busybox compiled with shared
libs.  I put glibc, ld and other libs in the /lib directory of the
initramfs.  My /init is an ash script, which basically runs busybox.
When boots, it just hangs in initramfs.

I use the same initramfs on other Intel pentium system and it works
fine.  It just fails on any of my VIA C3 systems, both with the stock
FC3 kernel and customed 2.6.11.7 kernel compiled specifically for
Cyrix/C3 and i586/i686.

When use static nash and busybox, it works (on C3).  Looking at the
code, the kernel does an execve() on either /linuxrc or /init.  On pentium
system, this works fine.  I just can't place why/how it fails on C3.  I 
tried
catching errno from execve to no avail.  I suspect that there is something
wrong with the library loader, but can't think of any thing why it differs
from Pentium and C3.  Can someone please shed some light?

I'm not subscribed to the list, so please CC me.  Thanks.

Dzuy
