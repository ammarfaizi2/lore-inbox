Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131457AbRDJLSz>; Tue, 10 Apr 2001 07:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131460AbRDJLSp>; Tue, 10 Apr 2001 07:18:45 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48132 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131457AbRDJLSh>; Tue, 10 Apr 2001 07:18:37 -0400
Subject: Re: No 100 HZ timer !
To: ak@suse.de (Andi Kleen)
Date: Tue, 10 Apr 2001 12:18:03 +0100 (BST)
Cc: mbs@mc.com (Mark Salisbury), jdike@karaya.com (Jeff Dike),
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010410075109.A9549@gruyere.muc.suse.de> from "Andi Kleen" at Apr 10, 2001 07:51:09 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14mw9t-00041m-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > interrupting decrementer.  (i.e just about any modern chip)
> 
> Just how would you do kernel/user CPU time accounting then ?  It's currently done 
> on every timer tick, and doing it less often would make it useless.

On the contrary doing it less often but at the right time massively improves
its accuracy. You do it on reschedule. An rdtsc instruction is cheap and all
of a sudden you have nearly cycle accurate accounting

Alan

