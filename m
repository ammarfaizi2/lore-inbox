Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423215AbWF1IPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423215AbWF1IPY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 04:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423217AbWF1IPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 04:15:24 -0400
Received: from aa002msr.fastwebnet.it ([85.18.95.65]:8873 "EHLO
	aa002msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1423215AbWF1IPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 04:15:22 -0400
Date: Wed, 28 Jun 2006 10:14:59 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: scary fcache trouble - silent data corruption(?)
Message-ID: <20060628101459.1375a27a@localhost>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, It's always me :)

This time I had a problem that scared me a bit...

Yesterday I've tested fcache for a while.

I have primed system boot + preferred applications startup, and then
I've used the system for a while.

Today I launch my mail-client (Sylpheed-Claws) and the Setup Wizard
dialog appears :-O!  (usually it appears when it isn't configured)

After a bit of reserch I've found that an XML config file
(.sylpheed-claws/folderlist.xml) was corrupted.

But it wasn't corrupted randomly, it was "replaced" with a peace of the
firefox cookies file :-X!


Now, Firefox and Sylpheed-Claws are 2 of the few application I've
primed... so my suspect is that there's some subtle BUG in fcache, or
maybe it's elsewhere since it is an experimental kernel after all...


Luckily	Sylpheed-Claws makes backup copy of every config file :)

The size of the corrupted file is almost identical to the backup one
(so it is probably equal to the size of the original one).


Even if there is really a BUG in fcache so that it can supply wrong
data I don't know how it got written to the real filesystem (since the
corruption persisted booting without fcache). Maybe Sylpheed-Claws have
read the file and then rewritten to it... I don't know.


Every time something like this happens I ask myself why I test
experimental things on my main PC...

I think this time I was lucky :)

-- 
	Paolo Ornati
	Linux 2.6.17-ga39727f2-dirty on x86_64
