Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265341AbTFMKoc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 06:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265342AbTFMKob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 06:44:31 -0400
Received: from mail.idoox.com ([194.213.203.154]:5641 "EHLO mail.idoox.com")
	by vger.kernel.org with ESMTP id S265341AbTFMKoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 06:44:25 -0400
Subject: Re: Cisco Aironet mini-PCI wireless card (MPI-350) [Was: Re: Intel
	PRO/Wireless 2100 vs. Broadcom BCM9430x]
From: Jan Mynarik <mynarikj@phoenix.inf.upol.cz>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1055439997.10219.54.camel@ixodes.goop.org>
References: <Pine.LNX.4.44.0306120813380.411-100000@twin.uoregon.edu>
	 <1055438410.930.15.camel@narsil>
	 <1055439997.10219.54.camel@ixodes.goop.org>
Content-Type: text/plain
Message-Id: <1055501888.1452.13.camel@narsil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 13 Jun 2003 12:58:08 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many thanks,

the patch worked well in the meaning of possible module insertion. But I
wasn't able to configure the card with ACU well.

With older firmware it's possible to insert module and to configure it
with ACU, but I'm not able to configure the card well. The whole
password menu produces segmentation fault :-))

Is there any other way how to configure this card? Unfortunately it
doesn't support wireless extensions.

Jan Mynarik

On Thu, 2003-06-12 at 19:46, Jeremy Fitzhardinge wrote:
> On Thu, 2003-06-12 at 10:20, Jan Mynarik wrote:
> > Cisco's linux support is great until you have IBM's ThinkPad R40. With
> > this notebook, their newest Linux driver (version 2.0, older ones do not
> > support my card) module (mpi350.o) can't be inserted to kernel (oops and
> > module remains 'initializing' forever). Module is compiled successfully
> > against both 2.4.20 and 2.4.21-rc7 kernels.
> > 
> > I'm just fighting their bureaucracy (in support) and trying to reach
> > someone who actually wrote the driver (module says Roland Wilcher). I
> > want to help him with testing and provide him with all possible
> > information.
> 
> Downgrade your firmware.  On the Cisco site, there's a Linux driver
> paired with a particular firmware version.  Use it: there's a bug in the
> kernel driver in which it reads stuff out of the card's RIDs into a
> local structure, but using the card's RID size.  The newer firmware has
> increased the structure sizes for some RIDs, which overruns the stack
> and crashes.
> 
> I have attached a patch for the driver to fix the crash, but I'm not
> confident the card works well without the correct firmware.
> 
> 	J
-- 
Jan Mynarik <mynarikj@phoenix.inf.upol.cz>

