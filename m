Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbVF1SNC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVF1SNC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 14:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbVF1SNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 14:13:02 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:45523 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262183AbVF1SMn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 14:12:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RVZEUpIIdjAfBX3CecteJFjaYD+/O8Wyil73dh+BNtiWoPk8MJeRjKf6mDwtPj5g5WmBeWnnqrimm6TRgqOTKFUgCzUfHNfGNOvUx6U3bdcMYUwCCxcYVUT/C0cd4R6nhmH1ntw826cUfdzwc/oWcHEn2U55STSL31KvV8jwkMU=
Message-ID: <94e67edf0506281112545d4766@mail.gmail.com>
Date: Tue, 28 Jun 2005 14:12:43 -0400
From: Sreeni <sreeni.pulichi@gmail.com>
Reply-To: Sreeni <sreeni.pulichi@gmail.com>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: Memory Management during Program Loading
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200506281800.j5SI0FEe011475@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <94e67edf05062810497c7a20b5@mail.gmail.com>
	 <200506281800.j5SI0FEe011475@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks you Valdis for your reply.

We have a "Bus Monitor hardware" which monitors and polices the bus at
the specified physical address.

Basically we need to run "secure" program under the supervision of the
Bus monitor hardware.

Kernel can see the "secure" memory region, and kernel is reponsible for enabling
the "Bus monitor Hardware". 

Thanks,
Sreeni

On 6/28/05, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> On Tue, 28 Jun 2005 13:49:46 EDT, Sreeni said:
> > In our system we have a secure physical memory starting and ending at
> > predefined addresses. We want to execute certain programs, which have
> > to be running secure in those address spaces only.
> 
> Can you explain how this memory is "secure", and how you expect a kernel that's
> running *outside* this secure space to load a program into it?
> 
> > Is it possible to force the loader to load the "particular" program
> > (both the code and data segment) at that pre-defined secure physical
> > memory, without any major kernel changes?
> 
> It's more complicated than that - not only do you need to worry about running
> the program in that space, you also need to worry about things like malloc()
> space for the program, I/O buffers, and so on.....
> 
> 
> 


-- 
~Sreeni
       -iDream
