Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271738AbRH2At6>; Tue, 28 Aug 2001 20:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271744AbRH2Ats>; Tue, 28 Aug 2001 20:49:48 -0400
Received: from zok.sgi.com ([204.94.215.101]:7578 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S271738AbRH2Atf>;
	Tue, 28 Aug 2001 20:49:35 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: haba@pdc.kth.se (Harald Barth), linux-kernel@vger.kernel.org
Subject: Re: Size of pointers in sys_call_table? 
In-Reply-To: Your message of "Tue, 28 Aug 2001 17:17:24 +0100."
             <E15blYK-0006Fb-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 29 Aug 2001 10:49:32 +1000
Message-ID: <20124.999046172@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2001 17:17:24 +0100 (BST), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> The layout of the sys_call_table is totally architecture dependant.  The
>> question to ask here is why do you need to use it?  Modifying it to hook
>> into syscalls is frowned upon.
>
>And potentially unsafe (think about caching, and non atomic writes on
>some platforms)

Not forgetting architectures like PPC64 and IA64 that require a
different function pointer format when syscall code is in a module.  A
simple replacement of a pointer in the syscall table will not work on
those architectures.

