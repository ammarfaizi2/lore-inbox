Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262266AbSLICuX>; Sun, 8 Dec 2002 21:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262296AbSLICuX>; Sun, 8 Dec 2002 21:50:23 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:33478 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S262266AbSLICuW>;
	Sun, 8 Dec 2002 21:50:22 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: /proc/pci deprecation?
References: <Pine.LNX.4.33.0212061601550.1010-100000@localhost.localdomain>
	<8bPzeb7mw-B@khms.westfalen.de>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 08 Dec 2002 21:01:55 +0100
In-Reply-To: <8bPzeb7mw-B@khms.westfalen.de>
Message-ID: <m3lm30l1os.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kaih@khms.westfalen.de (Kai Henningsen) writes:

> I use cat /proc/pci for the same reason I use cat /proc/scsi - when  
> configuring a box, or adding new hardware, to figure out what I should  
> look for and where it is.

Still there is lspci. Much better than just a file in /proc, in fact:
you can have short or long output, and you always have device and
vendor names (with /proc/pci it isn't true).
As long as the database contains the names, of course (the same as with
kernel, with the difference that it doesn't use kernel space).

> I don't particularly care which part of the file system this omes from,  
> but I do care about being able to find it quickly, and about it being easy  
> (i.e. not need looking at 7868 separate files) and giving the essential  
> info (which is the info that can be found in the relevant docs or be fed  
> to google).

Same as "ps xaf". I usually don't look at /proc/*/cmdline etc either.
This doesn't mean I want a file in /proc which contains "ps axf" output.

Anyway, /proc/pci is currently broken (the kernel don't know what
hot-pluggable devices will you use, and doesn't preserve the necessary
names). If we want it in /proc, could it be corrected?


I always thought of /proc/pci as of temporary q&d debug tool.
-- 
Krzysztof Halasa
Network Administrator
