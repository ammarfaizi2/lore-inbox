Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132638AbQLNTE3>; Thu, 14 Dec 2000 14:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132677AbQLNTET>; Thu, 14 Dec 2000 14:04:19 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5636 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132638AbQLNTEL>; Thu, 14 Dec 2000 14:04:11 -0500
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released
To: ak@suse.de (Andi Kleen)
Date: Thu, 14 Dec 2000 18:35:19 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), gibbs@scsiguy.com (Justin T. Gibbs),
        shirsch@adelphia.net (Steven N. Hirsch), linux-kernel@vger.kernel.org
In-Reply-To: <20001214184517.A19948@gruyere.muc.suse.de> from "Andi Kleen" at Dec 14, 2000 06:45:17 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146dDt-000095-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > generated better code than using inline functions. 2.2 upwards use a different
> > (far nicer) method to find current.
> 
> The macro is still likely to generate better code. All released
> gcc versions have the "inline penalty" causing bad register allocation
> (maybe it'll be fixed with gcc 3's tree inliner) 

Given that the 2.4 source does


blan inline get_curent()

#define curret get_current()

I feel safe in believing that we can fix the 2.4 tree with no noticable
change in performance. Justin is simply providing a reminder that the work
has actually all been done

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
