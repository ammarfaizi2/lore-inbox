Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130829AbRBQKsG>; Sat, 17 Feb 2001 05:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131020AbRBQKr4>; Sat, 17 Feb 2001 05:47:56 -0500
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:58886 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S130829AbRBQKrh>; Sat, 17 Feb 2001 05:47:37 -0500
To: linux-kernel@vger.kernel.org
Subject: Flushing buffer and page cache
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 17 Feb 2001 11:39:32 +0100
Message-ID: <tgzoflmw4b.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to flush all entries in the buffer cache corresponding
to a single block device (i.e. simply drop them if they aren't dirty,
or write them to disk and drop them after this if they are dirty)?

I've got another device in my SCSI chain which writes to the disk, and
if the caches are not flushed, the computer won't see the updates.
(Synchronization is done manually, so it's not an issue---trust me, I
know what I'm doing. ;-)

Kernel version doesn't matter. ;-)

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
