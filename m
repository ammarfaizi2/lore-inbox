Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268799AbUIXPCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268799AbUIXPCk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 11:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268760AbUIXPCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 11:02:39 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:669 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S268803AbUIXPCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 11:02:23 -0400
Message-ID: <4154364F.6060405@tiscali.it>
Date: Fri, 24 Sep 2004 16:59:27 +0200
From: Francesco Casadei <fr.casadei@tiscali.it>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040827)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: task_struct reference counting
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How one is supposed to handle the reference count of a task_struct from a 
kernel module?

get_task_struct() and put_task_struct() do not work, because the latter can't 
be used from a module, since it calls __put_task_struct(), which is not 
EXPORT_SYMBOL()'d.

I'm running 2.6.8.1.

Thanks in advance for your time,

	Francesco Casadei
