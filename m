Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287461AbSASVyi>; Sat, 19 Jan 2002 16:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287535AbSASVy2>; Sat, 19 Jan 2002 16:54:28 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:9202 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S287461AbSASVyW>;
	Sat, 19 Jan 2002 16:54:22 -0500
Message-Id: <200201192154.g0JLsIq19831@butler1.beaverton.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux (NUMA)
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: how many cpus can linux support for SMP?
Date: Sat, 19 Jan 2002 13:54:16 -0800
X-Mailer: KMail [version 1.3.1]
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Robert Love <rml@tech9.net>,
        Barry Wu <wqb123@yahoo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.3.96.1020119023636.6281A-100000@delta.ds2.pg.gda.pl>
In-Reply-To: <Pine.GSO.3.96.1020119023636.6281A-100000@delta.ds2.pg.gda.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 January 2002 05:41 pm, Maciej W. Rozycki wrote:
> On Fri, 18 Jan 2002, James Cleverdon wrote:
> > > Pentium 4 APICs have addressing up to 255 IIRC, so they can do more
> > > than P-III's 15.
> >
> > Yup.  xAPICs (and SAPICs for IA64) are the only ones that can get beyond
> > 14 (0x0F is the broadcast ID) using physical addressing.  I'm kicking
> > around some patches that use physical mode on a xAPIC NUMA box.
>
>  Note that the original i82489DX supported up to 255 APICs (0xff being the
> broadcast ID), so that's really nothing new and xAPICs are not the only
> ones.  Of course, i82489DX provides 32-bits for addressing in the logical
> mode.

True.  I wish that the ID size was the only thing that regressed when local 
APICs moved onto the CPU chip with the P54C.  Intel removing the ability to 
accept all interrupts and introducing new, poorly tested error states to 
"deal" with this limitation has haunted my code ever since....

-- 
James Cleverdon, IBM xSeries Platform (NUMA), Beaverton
jamesclv@us.ibm.com   |   cleverdj@us.ibm.com

