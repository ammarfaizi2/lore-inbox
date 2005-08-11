Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbVHKPNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbVHKPNS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbVHKPNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:13:18 -0400
Received: from nproxy.gmail.com ([64.233.182.205]:12155 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751075AbVHKPNR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:13:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gHnD88CzE1KaSMBpKK57eriUvchkRTnHUoLOWFbnO4hI7WgZuVE8b0uOZ+T6mbue63EPIRc0sRlwleTQefxA8Cup9GIGv8t54DotimoSzQSuzWgd8V8UdBqqW/NeT4buRoyKCCLk6eKSz81hby8stBI3vQONmDPf+4EQhwztTbo=
Message-ID: <2cd57c90050811081374d7c4ef@mail.gmail.com>
Date: Thu, 11 Aug 2005 23:13:13 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Need help in understanding x86 syscall
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org, Ukil a <ukil_a@yahoo.com>, 7eggert@gmx.de
In-Reply-To: <1123770661.17269.59.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4Ae73-6Mm-5@gated-at.bofh.it> <E1E3DJm-0000jy-0B@be1.lrz>
	 <Pine.LNX.4.61.0508110954360.14541@chaos.analogic.com>
	 <1123770661.17269.59.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/05, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 2005-08-11 at 10:04 -0400, linux-os (Dick Johnson) wrote:
> > Every interrupt software, or hardware, results in the branched
> > procedure being executed with the interrupts OFF. That's why
> > one of the first instructions in the kernel entry for a syscall
> > is 'sti' to turn them back on. Look at entry.S, line 182. This
> > occurs any time a trap occurs as well (Page 26-168, i486
> > Programmer's reference manual). FYI, this is helpful when
> > designing/debugging complex interrupt-service routines since
> > you can execute the interrupt with a software 'INT' instruction
> > (with the correct offset from the IRQ you are using). The software
> > doesn't 'know' where the interrupt came from, HW or SW.
> 
> I'm looking at 2.6.13-rc6-git1 line 182 of entry.S and I don't see it.
> Must be a different kernel.
> 
> According to the documentation that I was looking at, a trap in x86 does
> _not_ turn off interrupts.
> 
...
> 
> I don't see a sti here.
> 
> -- Steve
 

He is RBJ, Richard B. Johnson, the LKML defacto official troll.

-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
