Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293122AbSCWBPS>; Fri, 22 Mar 2002 20:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292617AbSCWBPJ>; Fri, 22 Mar 2002 20:15:09 -0500
Received: from zeus.kernel.org ([204.152.189.113]:41967 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S292289AbSCWBOs>;
	Fri, 22 Mar 2002 20:14:48 -0500
Subject: Block device driver in user space
From: Rolf =?ISO-8859-1?Q?Sch=E4uble?= <mail@rschaeuble.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 23 Mar 2002 01:44:13 +0100
Message-Id: <1016844254.1193.31.camel@desktop>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I'm thinking about a block device driver which is split between
kernel and user space.
But there are some things that give me a headache:

- Memory pressure:
The system runs out of free RAM. So the block buffer is freed by letting
all the devices write the data. So the userspace part is asked to
process some data. Therefore it might need more RAM, which will increase
the memory pressure. Therefore even more memory needs to be written.
Therefore the userspace part... I think you get the point.
Also, if the userspace part writes it data to the filesystem, it would
increase the memory pressure even further by causing new blocks to be
added to the cache.

Is there anything one could do to prevent this from happening (besides
from praying that there is always enough free memory)?

I'm just starting with kernel stuff, so this might as well a stupid
question. I've tried to find something in the archives, but with no
result.

Thanks for you answers.

Rolf

