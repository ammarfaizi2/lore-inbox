Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbULQNyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbULQNyB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 08:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbULQNyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 08:54:01 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:22938 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261159AbULQNx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 08:53:59 -0500
Message-Id: <200412171353.iBHDrueP007296@laptop11.inf.utfsm.cl>
To: firnnauriel <rinoa012000@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: bcopy and page faults 
In-Reply-To: Message from firnnauriel <rinoa012000@yahoo.com> 
   of "Wed, 15 Dec 2004 23:40:04 -0800." <20041216074004.46385.qmail@web53304.mail.yahoo.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Fri, 17 Dec 2004 10:53:55 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

firnnauriel <rinoa012000@yahoo.com> said:
> In general, is there a correlation between the number
> of page faults occurred in the system and bcopy's
> performance?

No.

>               If the page fault is high, will the
> bcopy's performance become slower? Kindly enlighten me
> on this. If you can provide a URL that will support
> your answer, I will really appreciate it. Thank you
> very much!

bcopy(3) copies stuff inside a process. If the memory areas copied from/to
are available in RAM, the copy will go at full speed. If not, there will be
delays (due to paging, etc). Now, the system might be paging like mad, but
the memory _this_ process requires is available (== full speed bcopy), or
there might be almost no paging activity, but the pages required for the
copy aren't in RAM (== slowest possible).

PS: Consider using memcpy(3), bcopy is non-standard.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
