Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262793AbVAKPXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbVAKPXl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 10:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbVAKPXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 10:23:41 -0500
Received: from rotfl.wrota.net ([81.21.195.197]:25800 "EHLO wrota.net")
	by vger.kernel.org with ESMTP id S262793AbVAKPXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 10:23:39 -0500
Date: Tue, 11 Jan 2005 16:23:39 +0100
From: Daniel Fenert <daniel@fenert.net>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "kernel BUG at mm/rmap.c:474!" error on 2.6.9
Message-ID: <20050111152338.GB31934@fenert.net>
Mail-Followup-To: Daniel Fenert <daniel@fenert.net>,
	Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org
References: <20050111095908.GA5041@fenert.net> <Pine.LNX.4.44.0501111331260.2603-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0501111331260.2603-100000@localhost.localdomain>
User-Agent: Mutt/1.4.2i
Organization: WROTA.net
X-Operating-System: Linux 2.4.26
X-Wyslij-mi-SMSa: Lepiej nie...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu Tue, Jan 11, 2005 at 02:09:51PM +0000, Hugh Dickins wystuka³(a):
>> What could be the real cause of such messages? (I assume that it was not
>> really apache or php fault (httpd and php shown in logs below)).
>
>It could easily be caused by bad memory bitflipping in a page table
>(but in general, we'd expect to be hearing of swap_free errors,
>or random corruption, if that were generally the case - I think).
>Please give memtest86 a good run to rule out that possibility.

I hardly can touch this machine, but I'll try tomorrow morning run memtest86
for some 20 minutes.

>If memtest86 is satifisfied, would you mind running with the patch
>below (against 2.6.9, suitable for i386 or x86_64, but not suitable
>for the various architectures which use PG_arch_1)?  To give us more
>debug info - it's unlikely to solve the mystery on it's own, but I
>hope it might help us to look in the right direction.  And send me
>any "Bad rmap" and "Bad page state" log entries you find (but
>perhaps this was a one-off, and nothing more will appear).

I'll try the patch.
This has happend for the first time (I have some problems with this
machine, but utill now there were only httpd(php) processes eating all
memory until machine is locked - that's why software watchdog is running
there).

-- 
Daniel Fenert                       --==> daniel@fenert.net <==--
====-P o w e r e d--b y--S l a c k w a r e-===-ICQ #37739641-====
Wonderful day. Your hangover just makes it seem terrible.
==========- http://daniel.fenert.net/ -==========< +48604628083 >
