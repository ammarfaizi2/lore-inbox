Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129699AbRCFXyt>; Tue, 6 Mar 2001 18:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129712AbRCFXyj>; Tue, 6 Mar 2001 18:54:39 -0500
Received: from nrg.org ([216.101.165.106]:36388 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S129699AbRCFXy0>;
	Tue, 6 Mar 2001 18:54:26 -0500
Date: Tue, 6 Mar 2001 15:53:45 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: Manoj Sontakke <manojs@sasken.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: spinlock help
In-Reply-To: <Pine.GSO.4.30.0103061926390.13816-100000@suns3.sasi.com>
Message-ID: <Pine.LNX.4.05.10103061549480.4692-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2001, Manoj Sontakke wrote:
> 1. when spin_lock_irqsave() function is called the subsequent code is
> executed untill spin_unloc_irqrestore()is called. is this right?

Yes.  The protected code will not be interrupted, or simultaneously
executed by another CPU.

> 2. is this sequence valid?
> 	spin_lock_irqsave(a,b);
> 	spin_lock_irqsave(c,d);

Yes, as long as it is followed by:

	spin_unlock_irqrestore(c, d);
	spin_unlock_irqrestore(a, b);

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

