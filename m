Return-Path: <linux-kernel-owner+w=401wt.eu-S1751083AbWLVRI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWLVRI2 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 12:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWLVRI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 12:08:28 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:44782 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbWLVRI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 12:08:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:mime-version:content-type:content-transfer-encoding:x-mailer:thread-index:x-mimeole:message-id;
        b=Sx6Hxp7T5TesIyBzZWiU7X1d1sU51B19mwwSLY/HoOaFs+1sqQzJaA9+z++qlBrCwfDvXVX6Z5gNzusyaTusA3hfezkX8QaYLvDo95cV6kWNQwSoZHlIFaaaKPGhTzi83MlNXAR4Rc8MZmvfj4GtCmQmRzDPhzmV/MM0Q1UNAe8=
From: "Roy Lee" <roylee17@gmail.com>
To: <linux-kernel@vger.kernel.org>
Cc: <roylee17@gmail.com>
Subject: Question about the io_context of I/O scheduler
Date: Sat, 23 Dec 2006 01:08:21 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: Accl68dbnE0Ynm/XRLuLSnLJCruQTw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Message-ID: <458c110a.07a24551.4274.ffff8727@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently tracing the I/O path of the kernel (2.6.19 release)

for the I/O scheduler, as far I as know, io_context is currently based on
per-process basis.
so, when an user process issued an I/O, the request generated in the kernel 
will be associated to the io_context of the "current" process, right?

but, isn't there some request generated in the kernel code which is not
relevant to the I/O pattern of the "current" user process?
for example, when the request generated to handle the page fault
or the kernel is paging out other process' pages due to memory pressure.

is this an issue or did I miss something?


thanks in advance for clearifying this.

