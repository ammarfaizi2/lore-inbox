Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVEQNTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVEQNTx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 09:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVEQNTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 09:19:52 -0400
Received: from mail.suse.de ([195.135.220.2]:19104 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261502AbVEQNTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 09:19:40 -0400
Date: Tue, 17 May 2005 15:19:32 +0200
From: Andi Kleen <ak@suse.de>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       randy_dunlap <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt.
Message-ID: <20050517131932.GF9699@wotan.suse.de>
References: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw> <20050516150907.6fde04d3.akpm@osdl.org> <Pine.LNX.4.62.0505161934220.25315@graphe.net> <20050516194651.1debabfd.rdunlap@xenotime.net> <Pine.LNX.4.62.0505161954470.25647@graphe.net> <Pine.LNX.4.58.0505162029240.18337@ppc970.osdl.org> <20050517034028.GC9699@wotan.suse.de> <4289CC97.9010105@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4289CC97.9010105@grupopie.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 11:51:03AM +0100, Paulo Marques wrote:
> Andi Kleen wrote:
> >>[...]
> >I would add a 
> >
> >	config HZ_10 if EMBEDDED 
> >		bool "10 Hz" 
> >
> >that is useful for compute servers (although it will violate the TCP
> >specification). EMBEDDED would ensure only people who know what they're
> >doing set it.
> 
> I thought the lowest frequency the PIT timer would give was around 18 Hz.
> 
> Am I wrong, or are you thinking of other timing devices / different 
> platforms?

I was thinking of HPET. You're right it would probably not work with 
PIT. 

Oh well, I guess it wasn't that great an idea anyways. I merely
suggested it because I know some people do it already.

-Andi
