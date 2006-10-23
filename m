Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751930AbWJWMca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbWJWMca (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 08:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbWJWMca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 08:32:30 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:45275 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751913AbWJWMcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 08:32:09 -0400
Date: Mon, 23 Oct 2006 14:32:54 +0200
From: Michael Holzheu <holzheu@de.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: schwidefsky@de.ibm.com
Subject: How to document dimension units for virtual files?
Message-Id: <20061023143254.496420f7.holzheu@de.ibm.com>
Organization: IBM
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the s390 hypervisor filesystem (s390_hypfs) we export performance
and status information to user space. In order to make parsing for
programs as easy as possilbe, we export exactly one value in one file
without adding the dimension unit to the output string.

For example:

cat /hypfs/cpus/onlinetime
476362365

cat /hypfs/memory
900620

As far as I know that is the recommended way of exporting such data
to user space, right?

The question is how to provide the dimension unit information to
the user.

I see three possibilites:

1. Write dimension unit into the output string (e.g. "476362365 kB"),
which makes parsing a bit more complicated.

2. Encode dimension unit into filename (e.g. onlinetime_ms or memory_kb)

3. Document dimension unit somewhere. In that case we need some central
place to provide such information. E.g. in the Documentation directory of
the linux kernel.

So, what is the recommended way?

Thanks!

Michael
