Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262408AbTCROQi>; Tue, 18 Mar 2003 09:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262410AbTCROQi>; Tue, 18 Mar 2003 09:16:38 -0500
Received: from 39.208-78-194.adsl-fix.skynet.be ([194.78.208.39]:31476 "EHLO
	mail.macqel.be") by vger.kernel.org with ESMTP id <S262408AbTCROQg>;
	Tue, 18 Mar 2003 09:16:36 -0500
Message-Id: <200303181427.h2IERQ110701@mail.macqel.be>
Subject: Re: sundance DFE-580TX DL10050B patch
In-Reply-To: <20030317174920.GC9667@gtf.org> from Jeff Garzik at "Mar 17, 2003
 12:49:20 pm"
To: Jeff Garzik <jgarzik@pobox.com>
Date: Tue, 18 Mar 2003 15:27:26 +0100 (CET)
CC: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
From: "Philippe De Muyter" <phdm@macqel.be>
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote :
> On Mon, Mar 17, 2003 at 06:40:36PM +0100, Philippe De Muyter wrote:
> > Dave Jones wrote :
> > > On Mon, Mar 17, 2003 at 02:56:09PM +0100, Philippe De Muyter wrote:
> > > 
> > >  > +		writew((dev->dev_addr[i + 1] << 8) + dev->dev_addr[i],
> > > 
> > > Don't you want to OR those together instead of add them ?
> > > 
> > > 		Dave
> > > 
> > You're right.
> 
> No.
> 
> Adding and or'ing are exactly equivalent for the above case, where you
> shift an 8-bit value left 8 bits, then add it to another 8-bit value.

That was implied in Dave's remark and in my answer.

> 
> The final answer may be obtained from examining the compiler's assembly
> output, and see which combination ('or' or 'add') produces the best
> code.

We can't do that as that should be done for all the supported processors.
Furthermore, it is the compiler's job to produce the best machine code.

The only thing we can do to help the compiler is write simple code.  From
a logical point of view, oring is what is needed here, and from a hardware
point of view oring is cheaper than adding.

> 	Jeff

Now, back to the real problem :) .  Will you apply my patch ?

Philippe

Philippe De Muyter  phdm@macqel.be  Tel +32 27029044
Macq Electronique SA  rue de l'Aeronef 2  B-1140 Bruxelles  Fax +32 27029077
