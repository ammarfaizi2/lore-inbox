Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbTBNTTg>; Fri, 14 Feb 2003 14:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266991AbTBNTTf>; Fri, 14 Feb 2003 14:19:35 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:46341
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264711AbTBNTTf>; Fri, 14 Feb 2003 14:19:35 -0500
Date: Fri, 14 Feb 2003 14:26:38 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Corey Minyard <cminyard@mvista.com>
cc: Werner Almesberger <wa@almesberger.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>, "" <suparna@in.ibm.com>,
       Kenneth Sumrall <ken@mvista.com>, "" <linux-kernel@vger.kernel.org>,
       "" <lkcd-devel@lists.sourceforge.net>
Subject: Re: Kexec, DMA, and SMP
In-Reply-To: <3E4D3419.1070207@mvista.com>
Message-ID: <Pine.LNX.4.50.0302141420220.3518-100000@montezuma.mastecende.com>
References: <20030211191027.A2999@in.ibm.com> <3E490374.1060608@mvista.com>
 <20030211201029.A3148@in.ibm.com> <3E4914CA.6070408@mvista.com>
 <m1of5ixgun.fsf@frodo.biederman.org> <3E4A578C.7000302@mvista.com>
 <m13cmty2kq.fsf@frodo.biederman.org> <3E4A70EA.4020504@mvista.com>
 <20030214001310.B2791@almesberger.net> <3E4CFB11.1080209@mvista.com>
 <20030214151001.F2092@almesberger.net> <3E4D3419.1070207@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2003, Corey Minyard wrote:

> Yes, some do and some don't.  You could define a new state for the
> "suspend" call that says "just shut down with no locks".  But the
> infrastructure is already in the PCI code and others to do a suspend,
> you could use that and take it out of all the CONFIG_PM ifdefs.

I don't think suspending devices is safe at that stage since removing 
devices and walking lists and freeing memory and disabling devices and... 
kicks up quite a storm.

	Zwane
-- 
function.linuxpower.ca
