Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312235AbSDCVcm>; Wed, 3 Apr 2002 16:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312238AbSDCVcc>; Wed, 3 Apr 2002 16:32:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38662 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312235AbSDCVcT>; Wed, 3 Apr 2002 16:32:19 -0500
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
To: tigran@aivazian.fsnet.co.uk (Tigran Aivazian)
Date: Wed, 3 Apr 2002 22:48:20 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), andrea@suse.de (Andrea Arcangeli),
        arjanv@redhat.com (Arjan van de Ven), hugh@veritas.com (Hugh Dickins),
        mingo@redhat.com (Ingo Molnar),
        stelian.pop@fr.alcove.com (Stelian Pop), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0204032207170.1612-100000@einstein.homenet> from "Tigran Aivazian" at Apr 03, 2002 10:26:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ssc8-0004b2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> commercial vendors can take advantage of and we should be careful about it
> but I still believe that exporting or not exporting symbols based on
> _license_ is fundamentally wrong.

_INTERNAL is basically the same thing in effect anyway. It clearly states
the symbol is an internal part of a GPL product so it would be very hard
for someone to argue their work was not derivative if they used one

> (and really needed) a simple boundary provided by EXPORT_SYMBOL and
> EXPORT_SYMBOL_INTERNAL (if _GPL gets renamed to it) is, imho, sufficient.

BTW thinking about compatibility. There is no reason the view insmod sees
can't remain the same. EXPORT_SYMBOL_INTERNAL can just do the same symbol
magic as before.

It also helps me with the kernel-doc stuff if EXPORT_SYMBOL_INTERNAL is
used and in 2.5 we go mark most of the random internal kernel symbols with it
because we can begin to generate complete docs of public export interfaces
and their functionality
