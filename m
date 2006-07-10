Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbWGJWUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbWGJWUg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965271AbWGJWUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:20:35 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:62400 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965270AbWGJWUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:20:34 -0400
Date: Mon, 10 Jul 2006 18:20:54 -0400
From: Mike Grundy <grundym@us.ibm.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Jan Glauber <jan.glauber@de.ibm.com>, linux-kernel@vger.kernel.org,
       systemtap@sources.redhat.com, dwilder@us.ibm.com
Subject: Re: [PATCH] kprobes for s390 architecture
Message-ID: <20060710222054.GA27908@localhost.localdomain>
Mail-Followup-To: Heiko Carstens <heiko.carstens@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Jan Glauber <jan.glauber@de.ibm.com>, linux-kernel@vger.kernel.org,
	systemtap@sources.redhat.com, dwilder@us.ibm.com
References: <OF44DB398C.F7A51098-ON88257196.007CD277-88257196.007DC8F0@us.ibm.com> <20060623222106.GA25410@osiris.ibm.com> <20060624113641.GB10403@osiris.ibm.com> <1151421789.5390.65.camel@localhost> <20060628055857.GA9452@osiris.boeblingen.de.ibm.com> <20060707172333.GA12068@localhost.localdomain> <20060707172555.GA10452@osiris.ibm.com> <20060708185428.GA26129@localhost.localdomain> <20060708195823.GA4112@localhost.localdomain> <20060710092852.GC9440@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060710092852.GC9440@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 11:28:52AM +0200, Heiko Carstens wrote:
> Whitespace :)
d'oh.
> You need a label behind the cs instruction and put that into the __ex_table,
> since the PSW will point to the instruction after cs if it fails.
Yeah, thought that was a nullify not a terminate. d'oh. d'oh.

> Also, on failure this function seems to return -EFAULT >> shift, which
> seems to be wrong.
Yeah. I think just returning the value without the shift would be ok. kprobes
never checks to see if the instruction swap was successful (which seems even
more wrong)

> > +EXPORT_SYMBOL(register_die_notifier);
> > +EXPORT_SYMBOL(unregister_die_notifier);
> _GPL?
Makes sense, but I kept it consistent with the rest of kprobes.

-- 
Thanks
Mike

=========================================
Michael Grundy - grundym@us.ibm.com

If at first you don't succeed, call in an air strike.

