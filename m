Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310456AbSCBVQM>; Sat, 2 Mar 2002 16:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310458AbSCBVQD>; Sat, 2 Mar 2002 16:16:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4872 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310456AbSCBVPt>;
	Sat, 2 Mar 2002 16:15:49 -0500
Message-ID: <3C814118.FAAF0502@mandrakesoft.com>
Date: Sat, 02 Mar 2002 16:16:08 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: christophe =?iso-8859-1?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
CC: linux-kernel@vger.kernel.org, Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Subject: Re: [PATCH] 3c509 Power Management (take 2)
In-Reply-To: <Pine.LNX.4.44.0203010826180.26745-100000@netfinity.realnet.co.sz> <Pine.LNX.4.44.0203011222010.31530-100000@netfinity.realnet.co.sz> <20020301093317.I22608@lynx.adilger.int> <20020302204839.GA4958@ufies.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

christophe barbé wrote:
> 
> On Fri, Mar 01, 2002 at 09:33:17AM -0700, Andreas Dilger wrote:
> > PS - any chance you can fix this for xirc2ps_cs?  I can test if you want,
> >      as my current card always fails to word after APM suspend (needs a
> >      "cardctl eject; cardctl insert" to work again.
> 
> It looks like there is a general problem concerning PM for pcmcia cards.
> I have a similar problem with a 3c59x card (which is managed by hotplug)
> and I am convinced that the problem is not in the driver code.

3c59x is 32-bit cardbus not 16-bit pcmcia... the code is very different
for the two in the kernel core.

That sounds more like a suspend and resume problem in 3c59x driver to
me...

-- 
Jeff Garzik      |
Building 1024    |
MandrakeSoft     | Choose life.
