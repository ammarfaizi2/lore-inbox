Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317168AbSFFUzY>; Thu, 6 Jun 2002 16:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317169AbSFFUzX>; Thu, 6 Jun 2002 16:55:23 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:36236 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S317168AbSFFUzX>; Thu, 6 Jun 2002 16:55:23 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [RFC] 4KB stack + irq stack for x86
To: davidm@hpl.hp.com
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF81A861D7.0F84A7BA-ONC1256BD0.0072344C@de.ibm.com>
From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Date: Thu, 6 Jun 2002 22:55:12 +0200
X-MIMETrack: Serialize by Router on D12ML028/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 06/06/2002 22:55:14
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Mosberger wrote:

>Just a minor nit: for ia64 it's either 32KB (for page sizes up to
>16KB) or 64KB (for 64KB page size).  The 32KB is conservative and
>based on the assumption that there can be up to 16 nested interrupts
>plus some other nested traps (such as unaligned faults).  A separate
>irq stack should let us reduce the per-task stack size.

So in the case of 8K page size, you need an order-2 allocation
for the stack, right?  How do you handle failures due to fragmentation?


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com


