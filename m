Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266467AbUH1MFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266467AbUH1MFe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 08:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266473AbUH1MFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 08:05:32 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:26050 "EHLO
	fmmailgate02.web.de") by vger.kernel.org with ESMTP id S266467AbUH1MFK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 08:05:10 -0400
Date: Sat, 28 Aug 2004 14:05:07 +0200
Message-Id: <1246770526@web.de>
MIME-Version: 1.0
From: "Joachim Bremer" <joachim.bremer@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: data loss in 2.6.9-rc1-mm1
Organization: http://freemail.web.de/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It may be architecture depend so here are my results:
machine: Tyan Thundewr K8W dual opteron with 2 G of memory, raid 4 on SATA drives
Distri: SuSE 9,1 64-bit, GCC 3.4.1
Stock 2.6.9-rc1-mm1: lots of errors. ldd on 32bit executables fail, reiserfsck fails on last block etc
2.6.9-rc1-mm1 with backed out pagecache patches: completely OK
2.6.9-rc1-mm1 with patch from Hugh Dickins: completely OK
2.6.9-rc1-mm1 Nick Piggin: only partially OK, will fail on reiserfsck with "bread End of file" on last block
of the md -device, random erros on compiling a kernel, mostly something like
"fs/ioctl.o: file not recognized: File truncated"

Joachim

________________________________________________________________
Verschicken Sie romantische, coole und witzige Bilder per SMS!
Jetzt neu bei WEB.DE FreeMail: http://freemail.web.de/?mc=021193

