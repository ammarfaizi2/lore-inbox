Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWJLM0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWJLM0F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 08:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbWJLM0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 08:26:04 -0400
Received: from hu-out-0506.google.com ([72.14.214.237]:56470 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751020AbWJLM0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 08:26:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=Nb3aX8blRRfoKg271ucJxWDBbUcLlJH0jXK2RK63DMIsIdxRhkYfSlvkuIopIgH2rd1Yqzjdzx60QCbdXDIhQcQaCaU5d3uQ0Sslxv8yTzH6iQv75yoZ5rOs6eA+e8g93QJ47bGufIjhaH3DwRrd0Udfl0V7ega5yFtWmI0YW1A=
Message-ID: <452E3451.1090907@innova-card.com>
Date: Thu, 12 Oct 2006 14:25:53 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Wrong __pa() usages in driver/char/mem.c ?
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm suprised to find some __pa() usages in a driver. I would
have used virt_to_phys() instead. In my understanding __pa()
is used only during early bootmem init, because this macro
is aware of any weird things that might exist at this early 
stage. But once this stage is completed virt_to_phys() should
be used.

Is this understanding wrong ?

Thanks
		Franck
