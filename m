Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288896AbSAXSub>; Thu, 24 Jan 2002 13:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288925AbSAXSuP>; Thu, 24 Jan 2002 13:50:15 -0500
Received: from holomorphy.com ([216.36.33.161]:22153 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S288896AbSAXStx>;
	Thu, 24 Jan 2002 13:49:53 -0500
Date: Thu, 24 Jan 2002 10:50:08 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, Barry Wu <wqb123@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Can linux support ccNUMA machine now?
Message-ID: <20020124105008.E872@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Barry Wu <wqb123@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020123003530.60778.qmail@web13903.mail.yahoo.com> <74750000.1011782724@flay> <20020123200405.D899@holomorphy.com> <200201241215.g0OCFSE10537@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <200201241215.g0OCFSE10537@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Thu, Jan 24, 2002 at 02:15:30PM -0200
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> P.S.: Blame it on struct page.

On Thu, Jan 24, 2002 at 02:15:30PM -0200, Denis Vlasenko wrote:
> Looks like running x86 with more than 16GB RAM is not a good idea.
> If you need it, you need 64bit arch.

There are more polite ways of refusing to boot in such situations,
ranging from just dropping the RAM that can't be used on the floor to
some effort to at make console messages explaining the panic visible.

On Thu, Jan 24, 2002 at 02:15:30PM -0200, Denis Vlasenko wrote:
> This limit can be raised substantially by reducing low 4GB memory 
> requirements, but don't you feel it's like running 16-bit DOS
> on 686 class CPU? HIMEM.SYS, EMM, horde of DOS extenders - sounds familiar?

Not familiar to me.

Reducing overhead helps all boxen everywhere all the time. Turning the
kernel upside-down for the corner case of 64GB isn't worth it, but
finding more graceful ways to fail than not booting with no visible
error messages, and perhaps extending the range of configurations where
the kernel actually functions (within reason) by reducing space
overhead is worthwhile.

I haven't seen many people posting questions to the list saying "Linux
won't boot, my machine is umpteen-way i386 SMP with 64GB of RAM". So I
largely think of it as a sort of reminder of the negative consequences
of overhead more than an actual goal, and the largest concern is that
the failure mode is not graceful.

On Thu, Jan 24, 2002 at 02:15:30PM -0200, Denis Vlasenko wrote:
> However, CPU vendors war over common 64-bit arch is still ahead...

64-bit machines have been what most CPU vendors have been selling for a
few years now. Unfortunately, "most vendors" does not translate to "most
CPU's in use", for non-technical reasons beyond the scope of this forum.


Cheers,
Bill
