Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbTLDE7r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 23:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbTLDE7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 23:59:46 -0500
Received: from [202.107.117.28] ([202.107.117.28]:3260 "EHLO smtp.neusoft.com")
	by vger.kernel.org with ESMTP id S263107AbTLDE7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 23:59:43 -0500
Date: Thu, 04 Dec 2003 13:01:09 +0800
From: fengxj <fengxiangjun@neusoft.com>
Subject: system() return different value under 2.4.23 and 2.6.0-test11
To: linux-kernel@vger.kernel.org
Message-id: <00b801c3ba23$a3115670$1801010a@fengxj>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
Content-type: text/plain; charset=gb2312
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, everyone

I just found a simple program:

-----------------------------
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>

int main(void)
{
        int ret;

        signal(SIGCHLD, SIG_IGN);

        ret = system("/bin/date 1>/dev/null");
        printf("%d\n", ret);

        return 0;
}
----------------------------

runs under 2.4.23 with ret = 0,
but under 2.6.0-test11, ret = -1.

Why?

And when i remove 
    signal(...)
it returns the same value 0. 

I use Slackware 9.1 with GCC 3.2.3 and libc 2.3.2


Regards.
