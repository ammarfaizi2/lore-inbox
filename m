Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264646AbSLaRwO>; Tue, 31 Dec 2002 12:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264654AbSLaRwO>; Tue, 31 Dec 2002 12:52:14 -0500
Received: from ool-4351594a.dyn.optonline.net ([67.81.89.74]:33550 "EHLO
	buggy.badula.org") by vger.kernel.org with ESMTP id <S264646AbSLaRwN>;
	Tue, 31 Dec 2002 12:52:13 -0500
Date: Tue, 31 Dec 2002 13:00:38 -0500
Message-Id: <200212311800.gBVI0cM15151@buggy.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NIC with polling support
In-Reply-To: <87el7yrvso.fsf@Login.CERT.Uni-Stuttgart.DE>
User-Agent: tin/1.5.12-20020427 ("Sugar") (UNIX) (Linux/2.4.20 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Dec 2002 17:35:19 +0100, Florian Weimer <Weimer@cert.uni-stuttgart.de> wrote:
> Dear all,
> 
> I guess I'm severe need of a 100BaseTX NIC with polling support in the
> driver.
> 
> A special application requires processing of 40,000 packets/second or
> more, and the interrupt load currently kills the machine (i.e. no
> scheduling during peak load).
> 
> Any suggestions which card I should use?  The driver has to be open
> source, and the card shouldn't be too expensive (i.e. in the usual
> price range of brand 100BaseTX NICs).

As far as I can tell, no driver in 2.4 supports NAPI (aka polling support)
with the exception of the tg3 driver -- but that's a GigE card.

The Adapter DuraLAN/Starfire driver (which I maintain) has been modified to
support NAPI, but those changes have not yet been included in the official
kernel. I can mail you the patch, if you want to give it a try. The cards
are on the expensive side, but not overly so (about $100/port).

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
