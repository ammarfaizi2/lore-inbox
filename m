Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263123AbTH0II0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 04:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263168AbTH0II0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 04:08:26 -0400
Received: from ns.keysirius162.de ([62.141.48.26]:64689 "EHLO keysirius162.de")
	by vger.kernel.org with ESMTP id S263123AbTH0IIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 04:08:25 -0400
Message-ID: <000001c36c73$128e4b60$e664a8c0@mike>
From: "Mike Greubel" <mike.kolping@pro-entertain.de>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.22 and Semaphore - Problem
Date: Wed, 27 Aug 2003 09:36:24 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list-readers,

I've got some errors on a test-box with kernel 2.4.22 and apache. After
'apache start' I got a error in SSLMutex, that this function is not
implemented. I straced my httpd and know now, that the error occures on:

= = = = cutted many lines = = = =

gettimeofday({1061968634, 157158}, NULL) = 0
write(10, "[Wed Aug 27 09:17:14 2003] [info"..., 91) = 91
semget(IPC_PRIVATE, 1, IPC_CREAT|0600)  = -1 ENOSYS (Function not
implemented)
gettimeofday({1061968634, 157633}, NULL) = 0
write(10, "[Wed Aug 27 09:17:14 2003] [erro"..., 88) = 88
write(2, "Configuration Failed\n\n", 22) = 22

= = = = cutted the rest = = = =

With 2.4.21 everything works fine so I continue with old version.

Just for your information, may this error is false positive?

Greetings
Mike

