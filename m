Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264319AbUDSJtP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 05:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbUDSJtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 05:49:15 -0400
Received: from mail.shareable.org ([81.29.64.88]:2980 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S264319AbUDSJtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 05:49:14 -0400
Date: Mon, 19 Apr 2004 10:48:33 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Eric <eric@cisu.net>
Cc: linux-kernel@vger.kernel.org, "Stephan T. Lavavej" <stl@nuwen.net>
Subject: Re: Process Creation Speed
Message-ID: <20040419094833.GB13007@mail.shareable.org>
References: <200404170219.i3H2JYal007333@localhost.localdomain> <200404182115.20922.eric@cisu.net> <20040419030456.GA11717@mail.shareable.org> <200404190043.04358.eric@cisu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404190043.04358.eric@cisu.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric wrote:
> > None of this answers the question which is relevant to linux-kernel:
> > why does process creation take 7.5ms and fail to scale with CPU
> > internal clock speed over a factor of 4 (600MHz x86 to 2.2GHz x86).
> 
> The reason it doesn't scale is probably because the kernel always runs at a 
> specified speed, 100HZ which leaves 10ms(i believe?) timeslices. I would try 
> a HZ patch and bump it up to 1000, i bet you would see a big difference then.

Hmm.  The timer speed shouldn't affect the measured speed of fork() at
all.  It might show up if the measuring program is dependent on the
timer in some way, though.

-- Jamie
