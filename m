Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264855AbUD2Uxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbUD2Uxx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264858AbUD2UuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:50:08 -0400
Received: from mail0-105.ewetel.de ([212.6.122.105]:26777 "EHLO
	mail0.ewetel.de") by vger.kernel.org with ESMTP id S264850AbUD2UtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:49:07 -0400
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible permissions bug on NFSv3 kernel client
In-Reply-To: <1QnPD-2pg-1@gated-at.bofh.it>
References: <1QhAA-5zc-13@gated-at.bofh.it> <1QnPD-2pg-1@gated-at.bofh.it>
Date: Thu, 29 Apr 2004 22:49:02 +0200
Message-Id: <E1BJISs-0000MM-W0@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2004 19:50:06 +0200, you wrote in linux.kernel:

>> ...so that the the MODIFY and EXTEND bits aren't set when writing to a
>> block or character device.
>
> Hmm... Why shouldn't the MODIFY bit at least be set if the user
> requested write access to the device?

It's somewhat of a mixed-up situation for device nodes exported via
NFSv3. Permission bits are on the server, but the actual write does
not happen via NFS (as v3 WRITE only works on regular files).

-- 
Ciao,
Pascal
