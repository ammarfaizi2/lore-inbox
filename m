Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286258AbRLTOGl>; Thu, 20 Dec 2001 09:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286259AbRLTOGc>; Thu, 20 Dec 2001 09:06:32 -0500
Received: from unamed.infotel.bg ([212.39.68.18]:33036 "EHLO l.himel.bg")
	by vger.kernel.org with ESMTP id <S286258AbRLTOGR>;
	Thu, 20 Dec 2001 09:06:17 -0500
Date: Thu, 20 Dec 2001 16:10:11 +0200 (EET)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: <ja@l>
To: bert hubert <ahu@ds9a.nl>
cc: <kuznet@ms2.inr.ac.ru>, <netdev@oss.sgi.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [BUG/FIXED !] Equal Cost Multipath Broken in 2.4.x
In-Reply-To: <20011220145332.A15230@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.33.0112201605120.9578-100000@l>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Thu, 20 Dec 2001, bert hubert wrote:

> must have not been awake this morning. It does apply now, AND fixes the
> problem. Thanks!

	Very good

> > [010803]
> >  * If "dev" is not specified in multipath route, ifindex remained
> >    uninitialized. Grr. Thanks to Kunihiro Ishiguro <kunihiro@zebra.org>.
>
> I do specify dev on the commandline, however, you are right in that is the
> compiler that fixes the behaviour. Apparently, gcc-3.0 is lucky in this
> respect.

	Yes, it seems dev is an old problem. IMO the right fix is to
memset with 0 the struct before usage. This will avoid any further errors.

> I happened to be compiling with gcc-3.0 at the time, while debian compile
> their packages with gcc-2.95. I'll mention this patch on the LARTC
> mailinglist too.

	Yes, it must depend somehow on the compiler, may be from
previous calls of other functions, no time to investigate.

> Will you push this patch towards Alexey?

	If he is not reading the whole thread, please, do it directly.

> Regards,
>
> bert

Regards

--
Julian Anastasov <ja@ssi.bg>

