Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264889AbUDWRf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264889AbUDWRf4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 13:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264890AbUDWRf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 13:35:56 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:10942 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S264889AbUDWRfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 13:35:46 -0400
Message-Id: <200404231735.i3NHZRp3012111@eeyore.valparaiso.cl>
To: weddy@grc.nasa.gov
cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: TCP rto estimation patch 
In-Reply-To: Message from Wesley Eddy <weddy@grc.nasa.gov> 
   of "Fri, 23 Apr 2004 10:24:45 -0400." <20040423142445.GC501@grc.nasa.gov> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Fri, 23 Apr 2004 13:35:27 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wesley Eddy <weddy@grc.nasa.gov> said:
> The TCP RTO estimation algorithm defined in RFC 2988 is followed properly
> in the kernel, however the constants alpha and beta in the specification
> are hardcoded as 3 and 2 everywhere they occur in the kernel.  Since these
> constants crop up multiple times, this is poor programming practice.  This
> patch binds the numeric values to symbols RTT_ALPHA and RTTVAR_BETA, and
> uses those symbolic values throughout the code.  Since using 2 and 3 for
> these values is not mandatory, this makes tweaking them much easier.

Why RTT_ALPHA and RTTVAR_BETA, and not just RTT_BETA? Or even RTO_xxx?

Is there any reason to change them, ever? What happens if you change them?
Restrictions on values? All this should go with such a patch IMHO (at least
pointers to relevant discussion).

Must go over it with a fine comb to make sure no unrelated 2 or 3 got
replaced... out of my league, sorry.

Your patch is MIME-mangled, =3D, =20, =\n shows up all over the place here.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
