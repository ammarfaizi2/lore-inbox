Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264436AbTLGPK2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 10:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbTLGPK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 10:10:28 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:13696 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264436AbTLGPK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 10:10:27 -0500
Date: Sun, 7 Dec 2003 15:15:46 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200312071515.hB7FFkQH000866@81-2-122-30.bradfords.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Additional clauses to GPL in network drivers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many network drivers in the current 2.6 tree include the following
licensing condition/clarification, in addition to being placed under
the GPL:

"This file is not a complete program and may only be used when the
entire operating system is licensed under the GPL".

as
grep -C 1 "only be used when"

in drivers/net will confirm.

*Please*, can we resist the temptation to 'play' with licenses in this
way?  I suspect this extra clause was added just to clarify what the
GPL already says, but in doing so, it just confuses matters, and ends
up causing more work.

For example, it brings up a few issues:

1. How is 'operating system' supposed to be defined in this context?

I assume that if it meant just the kernel, it would say 'kernel'.

If you define 'operating system' as including some userspace
utilities, it's going to cause problems, as some common utilities are
not GPL'ed, (the extra clause doesn't say 'GPL-compatible', it
specifically specifies GPL).

2. Is code licensed under this extra term actually compatible with
code placed under the GPL alone?

3. I haven't tried to trace the history of this code, but if these
drivers were based on, and include, other developer's purely GPL'ed
code, applying this extra condition is presumably not valid, (unless
specific permission was sought to do so).

4. The obvious issue concerning binary modules - does loading a binary
module which is not licensed under the GPL invalidate your license to
use these network drivers?  Note that I personally have no interest
whatsoever in using such binary modules, but whatever ends up being
decided for the GPL'ed parts of the kernel, this extra clause suggests
to me that it specifically isn't OK whilst using these network
drivers.

John.
