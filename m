Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269988AbUIDAKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269988AbUIDAKx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 20:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269997AbUIDAKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 20:10:53 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:20595 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269988AbUIDAKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 20:10:47 -0400
Message-ID: <311601c904090317107136bd43@mail.gmail.com>
Date: Fri, 3 Sep 2004 18:10:46 -0600
From: Eric Mudama <edmudama@gmail.com>
Reply-To: Eric Mudama <edmudama@gmail.com>
To: Greg Stark <gsstark@mit.edu>
Subject: Re: Crashed Drive, libata wedges when trying to recover data
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Brad Campbell <brad@wasp.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <87k6vbs0a9.fsf@stark.xeocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <87oekpvzot.fsf@stark.xeocode.com>
	 <87u0ugt0ml.fsf@stark.xeocode.com>
	 <1094209696.7533.24.camel@localhost.localdomain>
	 <87d613tol4.fsf@stark.xeocode.com>
	 <1094219609.7923.0.camel@localhost.localdomain>
	 <877jrbtkds.fsf@stark.xeocode.com>
	 <1094224166.8102.7.camel@localhost.localdomain>
	 <871xhjti4b.fsf@stark.xeocode.com>
	 <311601c904090310083d057c25@mail.gmail.com>
	 <87k6vbs0a9.fsf@stark.xeocode.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03 Sep 2004 13:57:34 -0400, Greg Stark <gsstark@mit.edu> wrote:
> 
> Eric Mudama <edmudama@gmail.com> writes:
> 
> > Boom, you're deadlocked. This means that in SATA, the only way to overcome
> > this deadlock in the driver is to have the host/board generate a COMRESET
> > OOB burst to hard-reset the drive.
> 
> So now I'm wondering if there's a way to coerce the libata drivers to generate
> this?
> 
> > Today's (and tomorrow's) generation of SATA drives will never ever
> > generate a 0x59 status... the error and DRQ bits become mutually
> > exclusive.  However, unfortunately, there are quite a few drives in
> > the field which have this behavior...
> 
> I read somewhere that the current generation of SATA drives from everyone
> except Seagate were really PATA with a "bridge". It sounded like BS to me, but
> is that why they're behaving like PATA drives as far as these error codes? Or
> is it simply a question of the shared firmware codebase?

Our (Maxtor's) first generation of SATA drives were all bridged
products.  Our new drive (slowly appearing today) is a native sata
product that support NCQ.
