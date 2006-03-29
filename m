Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWC2Np0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWC2Np0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 08:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWC2NpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 08:45:25 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:10374 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1750726AbWC2NpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 08:45:25 -0500
Date: Wed, 29 Mar 2006 15:45:24 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Kirill Korotaev <dev@openvz.org>
Cc: devel@openvz.org, Kir Kolyshkin <kir@sacred.ru>,
       linux-kernel@vger.kernel.org, sam@vilain.net
Subject: Re: [Devel] Re: [RFC] Virtualization steps
Message-ID: <20060329134524.GA14522@MAIL.13thfloor.at>
Mail-Followup-To: Kirill Korotaev <dev@openvz.org>, devel@openvz.org,
	Kir Kolyshkin <kir@sacred.ru>, linux-kernel@vger.kernel.org,
	sam@vilain.net
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au> <1143228339.19152.91.camel@localhost.localdomain> <4428BB5C.3060803@tmr.com> <4428DB76.9040102@openvz.org> <1143583179.6325.10.camel@localhost.localdomain> <4429B789.4030209@sacred.ru> <1143588501.6325.75.camel@localhost.localdomain> <442A4FAA.4010505@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442A4FAA.4010505@openvz.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 01:13:14PM +0400, Kirill Korotaev wrote:
> Sam,
> 
> >>Why do you think it can not be measured? It either can be, or it is too 
> >>low to be measured reliably (a fraction of a per cent or so).
> >
> >Well, for instance the fair CPU scheduling overhead is so tiny it may as
> >well not be there in the VServer patch.  It's just a per-vserver TBF
> >that feeds back into the priority (and hence timeslice length) of the
> >process.  ie, you get "CPU tokens" which deplete as processes in your
> >vserver run and you either get a boost or a penalty depending on the
> >level of the tokens in the bucket.  This doesn't provide guarantees, but
> >works well for many typical workloads.

> I wonder what is the value of it if it doesn't do guarantees or QoS?
> In our experiments with it we failed to observe any fairness. 

probably a misconfiguration on your side ...

> So I suppose the only goal of this is too make sure that maliscuios
> user want consume all the CPU power, right?

the currently used scheduler extensions do much
more than that, basically all kinds of scenarios
can be satisfied with it, at almost no overhead

> >How does your fair scheduler work?  
> >Do you just keep a runqueue for each vps?
> we keep num_online_cpus runqueues per VPS.

> Fairs scheduler is some kind of SFQ like algorithm which selects VPS
> to be scheduled, than standart linux scheduler selects a process in a
> VPS runqueues to run.
> 
> >To be honest, I've never needed to determine whether its overhead is 1%
> >or 0.01%, it would just be a meaningless benchmark anyway :-).  I know
> >it's "good enough for me".

> Sure! We feel the same, but people like numbers :)

well, do you have numbers?

best,
Herbert

> Thanks,
> Kirill
