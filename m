Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264249AbTH1Vtg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 17:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264295AbTH1Vtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 17:49:36 -0400
Received: from quechua.inka.de ([193.197.184.2]:16605 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S264249AbTH1VtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 17:49:14 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Lockless file reading
In-Reply-To: <20030828121823.GB6800@mail.jlokier.co.uk>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19sUde-0003Iv-00@calista.inka.de>
Date: Thu, 28 Aug 2003 23:49:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030828121823.GB6800@mail.jlokier.co.uk> you wrote:
> The kernel does not provide synchronisation between read() and write()
> data transfers, and it does not always use atomic 32-bit reads and
> writes either.

There are some gurantees for pipes, for example. Writes which are smaller
than pathconf(_PC_PIPE_BUF, pipe) will be atomic, i.e. not mixed between
multiple writers. I dont know what the gurantee for write/read or mmap is.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
