Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWEQB2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWEQB2a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 21:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWEQB23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 21:28:29 -0400
Received: from mx1.suse.de ([195.135.220.2]:8066 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932412AbWEQB23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 21:28:29 -0400
From: Andi Kleen <ak@suse.de>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Subject: Re: [RFC] [Patch 7/8] statistics infrastructure - exploitation prerequisite
Date: Wed, 17 May 2006 03:27:51 +0200
User-Agent: KMail/1.9.1
Cc: Arnd Bergmann <arnd@arndb.de>, Martin Peschke <mp3@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       hch@infradead.org, arjan@infradead.org, James.Smart@emulex.com,
       James.Bottomley@steeleye.com
References: <446A1023.6020108@de.ibm.com> <200605170103.08917.arnd@arndb.de> <17514.31511.386806.484792@wombat.chubb.wattle.id.au>
In-Reply-To: <17514.31511.386806.484792@wombat.chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605170327.52605.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Anrd> - do_gettimeofday
> Anrd>   potentially slow, reliable TOD clock, microsecond resolution
> 
> Slow, not necessarily safe to call in IRQ context.

It's only slow if the platform can't do better. On good hardware it is 
fast. And yes it is safe to call in IRQ context. Networking does 
that all the time.

If the hardware doesn't have a good working timer for gettimeofday 
then everything else will be also slow. 

-Andi
