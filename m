Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269703AbUICSC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269703AbUICSC7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 14:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269599AbUICSC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 14:02:58 -0400
Received: from gsstark.mtl.istop.com ([66.11.160.162]:42631 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S269742AbUICR5r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 13:57:47 -0400
To: Eric Mudama <edmudama@gmail.com>
Cc: Greg Stark <gsstark@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Brad Campbell <brad@wasp.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Crashed Drive, libata wedges when trying to recover data
References: <87oekpvzot.fsf@stark.xeocode.com> <4136E277.6000408@wasp.net.au>
	<87u0ugt0ml.fsf@stark.xeocode.com>
	<1094209696.7533.24.camel@localhost.localdomain>
	<87d613tol4.fsf@stark.xeocode.com>
	<1094219609.7923.0.camel@localhost.localdomain>
	<877jrbtkds.fsf@stark.xeocode.com>
	<1094224166.8102.7.camel@localhost.localdomain>
	<871xhjti4b.fsf@stark.xeocode.com>
	<311601c904090310083d057c25@mail.gmail.com>
In-Reply-To: <311601c904090310083d057c25@mail.gmail.com>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 03 Sep 2004 13:57:34 -0400
Message-ID: <87k6vbs0a9.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Eric Mudama <edmudama@gmail.com> writes:

> Boom, you're deadlocked. This means that in SATA, the only way to overcome
> this deadlock in the driver is to have the host/board generate a COMRESET
> OOB burst to hard-reset the drive.

So now I'm wondering if there's a way to coerce the libata drivers to generate
this?

> Today's (and tomorrow's) generation of SATA drives will never ever
> generate a 0x59 status... the error and DRQ bits become mutually
> exclusive.  However, unfortunately, there are quite a few drives in
> the field which have this behavior...

I read somewhere that the current generation of SATA drives from everyone
except Seagate were really PATA with a "bridge". It sounded like BS to me, but
is that why they're behaving like PATA drives as far as these error codes? Or
is it simply a question of the shared firmware codebase?

-- 
greg

