Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbUKVCZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbUKVCZU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 21:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbUKVCZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 21:25:20 -0500
Received: from [202.131.75.34] ([202.131.75.34]:38345 "EHLO
	mail.shaolinmicro.com") by vger.kernel.org with ESMTP
	id S261898AbUKVCZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 21:25:16 -0500
Message-ID: <41A14E0B.3030608@shaolinmicro.com>
Date: Mon, 22 Nov 2004 10:25:15 +0800
From: David Chow <davidchow@shaolinmicro.com>
Organization: Shaolin Microsystems Ltd.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; zh-TW; rv:1.4.2) Gecko/20040612
X-Accept-Language: zh_TW, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: dequeue_signal() in signal.c disabilities
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any reason to explicitly export dequeue_signal() as GPL in
signal.c ? I am not sure it is done by accident or not, but it is
definitely not quite reasonable to do this while other symbols in the
same source file are using EXPORT_SYMBOL() instead of EXPORT_SYMBOL_GPL().

This causes disabilities with modules that are non pure GPL licensed,
this causes kernel threads or possibly other interrupts unable to be
handled properly. I've tried both BSD and LGPL which doesn't work. The
dequeue_signal() is essential to anyone who use sleeps with signals and
will force non-pure-GPL'ed modules unable to handle signals properly.
Can anyone fix this in the next release of the kernel or give me a
simple reponse? Thanks.

David


