Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262953AbVHEKSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbVHEKSf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 06:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbVHEKSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 06:18:14 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:18315 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S262953AbVHEKPq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 06:15:46 -0400
Message-ID: <2153.192.168.201.6.1123236941.squirrel@www.masroudeau.com>
In-Reply-To: <200508041645.23825.gustavo@compunauta.com>
References: <3235.192.168.201.6.1123157467.squirrel@www.masroudeau.com>
    <200508041645.23825.gustavo@compunauta.com>
Date: Fri, 5 Aug 2005 11:15:41 +0100 (BST)
From: "Etienne Lorrain" <etienne.lorrain@masroudeau.com>
To: Gustavo Guillermo =?iso-8859-1?Q?P=E9rez?= 
	<gustavo@compunauta.com>
Cc: linux-kernel@vger.kernel.org
Reply-To: etienne.lorrain@masroudeau.com
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
X-Priority: 3 (Normal)
Importance: Normal
X-SA-Exim-Connect-IP: 192.168.2.240
X-SA-Exim-Mail-From: etienne.lorrain@masroudeau.com
Subject: Re: IDE disk and HPA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on cygne.masroudeau.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I want to upgrade my IDE Hard drive by my self, how can I
> restore that kind of data on other diferent PC?

  So the content of the HPA should be limited to program which are
 special: a boot loader is position dependant and you do not want
 to copy it blindly to another hard disk with maybe another size
 or other characteristics - because it will not work - you just
 want to re-install it on the other HD on the other PC.
  If this HPA contains more than a bootloader, it has to be
 organised like a real filesystem (or even a real device image
 with a partition table) to be accessed by emergency tools like
 mtools (you can specify a big offset to the device to access
 a FAT partition at the end of the device). This FAT filesystem
 can be considered logically like a big floppy.
 Maybe one day this system can use the SAORAB IDE feature - read
 the spec to understand that sentence.
  If you are really recovering a disaster and want to get the HPA
 content but are locked by the bootloader blocking this access, I'll
 give you the trick (that is a secret - do not repeat it!): plug in
 your IDE disk after boot using an USB/IDE adapter.

> HPA should not exist, there are a lot of other ways to store
> restore or diagnostics apps, Hibernation and Quick Restores
> should be handled in other way, I have once an omnibook (earth
> unplugged) and I can only reinstall Linux, because the host
> protected area does not allow me to install The Original OS,
> in other PC with the porper hardware and back it to the laptop.

  HPA and all the other "extended" IDE command exists on all hard
 drives used these day: anything more than 8 Gb has the complete
 set (but maybe SAORAB).

> This HPA should be optional, but never by default, I once need
> to have them disabled (where is the specifications from the
> manufacturer to reproduce them in a new hard disk media).

  My bootloader can be installed in any standard partition and
 if the disk does not contains a B.E.E.R. sector (see
http://www.t13.org/project/d1367r3.pdf
 ) you will not get the HPA set or frozzen.
 Security freeze is still done in all cases.

  Etienne.

