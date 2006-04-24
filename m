Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWDXUTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWDXUTr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWDXUTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:19:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37015 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751217AbWDXUTq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:19:46 -0400
Date: Mon, 24 Apr 2006 13:19:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: better leve triggered IRQ management needed
In-Reply-To: <Pine.LNX.4.61.0604241529360.24459@chaos.analogic.com>
Message-ID: <Pine.LNX.4.64.0604241319030.3701@g5.osdl.org>
References: <20060424114105.113eecac@localhost.localdomain>
 <Pine.LNX.4.64.0604241156340.3701@g5.osdl.org> <Pine.LNX.4.61.0604241529360.24459@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Apr 2006, linux-os (Dick Johnson) wrote:
> > one user and the driver is properly written. Making request_irq() fail
>    ^^^^^^^^_______ Must be a trick!
> > would break existing and working setups.
> >
> 
> If there is just one user then it isn't shared! Get real.

SA_SHIRQ does NOT mean that the irq is shared.

It means that it's not exclusive, and that the driver is _ok_ with it 
being shared if that makes sense.

		Linus
