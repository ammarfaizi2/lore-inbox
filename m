Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264987AbTFUGWJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 02:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264989AbTFUGWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 02:22:09 -0400
Received: from quechua.inka.de ([193.197.184.2]:63716 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S264987AbTFUGWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 02:22:07 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] nbd driver for 2.5.72
In-Reply-To: <3EF3F08B.5060305@aros.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19Tbyp-0004mi-00@calista.inka.de>
Date: Sat, 21 Jun 2003 08:36:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3EF3F08B.5060305@aros.net> you wrote:
> There's 
> definately room for more improvements
...
> + * 03-06-12 Added a default BLOCKING stratedgy on network downtime with a
> + *   non-default NBD_NONBLOCKING flag. This has the net effect of blocking
> + *   I/O when there's only transient problems like a server reboot. If used
> + *   in conjunction now with RAID mirroring, transient errors (while they'll
> + *   pause the system) will not nessesitate a complete recopying of the
> + *   server's exported block device which could potentially take much longer
> + *   than a reboot.

Is anybody aware of a journalling nbd, which keeps track of unsynced
changes, so a fast reintegration is possible?

Well perhaps this is a property of the md device, instead... hmm. Is there
such a function available? Could be some left over from snapshot code.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
