Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262784AbSI3RwH>; Mon, 30 Sep 2002 13:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262793AbSI3RwH>; Mon, 30 Sep 2002 13:52:07 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:33216 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262784AbSI3RwH>; Mon, 30 Sep 2002 13:52:07 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Arnd Bergmann <arndb@de.ibm.com>
To: Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH] 2.5.39 s390 (3/26): drivers.
Date: Mon, 30 Sep 2002 19:58:10 +0200
User-Agent: KMail/1.4.3
Cc: lkml <linux-kernel@vger.kernel.org>,
       "Martin Schwidefsky" <schwidefsky@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209301957.04743.arnd@bergmann-dalldorf.de>
Reply-To: arnd@bergmann-dalldorf.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ehm. Ok. This code STILL tries to read and parse config files. If you're
> fixing it, can you please fix it to NOT read and parse config files from
> inside the kernel? Please? 

This is just a fix to keep chandev working as long as it's there and
drivers depend on it. We're working on getting rid of chandev altogether,
as we don't need any more it once driverfs and hotplug are working well 
for s390 ccw devices.

The new code is not stable yet and so far works only for qeth and dasd,
so there is not much point in breaking everything else atm.

	Arnd <><
