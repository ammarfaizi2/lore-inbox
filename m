Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316309AbSGLNPP>; Fri, 12 Jul 2002 09:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316322AbSGLNPO>; Fri, 12 Jul 2002 09:15:14 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:33787 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S316309AbSGLNPN>; Fri, 12 Jul 2002 09:15:13 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200207112135.OAA03801@csl.Stanford.EDU> 
References: <200207112135.OAA03801@csl.Stanford.EDU> 
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Jul 2002 14:17:29 +0100
Message-ID: <32493.1026479849@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


engler@csl.Stanford.EDU said:
> /u2/engler/mc/oses/linux/2.5.8/drivers/mtd/chips/cfi_cmdset_0001.c:782:
> do_write_buffer: ERROR:A_B:700:782:Did not reverse 'spin_lock'
> [COUNTER=spin_lock:700] [fit=3] [fit_fn=1] [fn_ex=5] [fn_counter=1]
> [ex=5619] [counter=272] [z = 1.34804760770983] [fn-z =
> -1.31122013621437] 

That one can't ever actually happen -- it's effectively a default case in a
switch statement which can't ever be reached because we'd never get that far
unless one of the real cases is going to be taken. I think I'll replace the
return statement with panic("The world is broken");


--
dwmw2


