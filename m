Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbUDSMJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 08:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264381AbUDSMJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 08:09:59 -0400
Received: from mail.convergence.de ([212.84.236.4]:31393 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S264366AbUDSMJ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 08:09:57 -0400
Date: Mon, 19 Apr 2004 14:09:57 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Eric <eric@cisu.net>, linux-kernel@vger.kernel.org,
       "Stephan T. Lavavej" <stl@nuwen.net>
Subject: Re: Process Creation Speed
Message-ID: <20040419120957.GB3764@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Jamie Lokier <jamie@shareable.org>, Eric <eric@cisu.net>,
	linux-kernel@vger.kernel.org, "Stephan T. Lavavej" <stl@nuwen.net>
References: <200404170219.i3H2JYal007333@localhost.localdomain> <200404182115.20922.eric@cisu.net> <20040419030456.GA11717@mail.shareable.org> <200404190043.04358.eric@cisu.net> <20040419094833.GB13007@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040419094833.GB13007@mail.shareable.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Eric wrote:
> > > None of this answers the question which is relevant to linux-kernel:
> > > why does process creation take 7.5ms and fail to scale with CPU
> > > internal clock speed over a factor of 4 (600MHz x86 to 2.2GHz x86).
> > 
> > The reason it doesn't scale is probably because the kernel always runs at a 
> > specified speed, 100HZ which leaves 10ms(i believe?) timeslices. I would try 
> > a HZ patch and bump it up to 1000, i bet you would see a big difference then.
> 
> Hmm.  The timer speed shouldn't affect the measured speed of fork() at
> all.  It might show up if the measuring program is dependent on the
> timer in some way, though.

http://bulk.fefe.de/scalability/ has some benchmarks on the issue.
But I guess the numbers depend heavily on the server/CGI software used.

Johannes
