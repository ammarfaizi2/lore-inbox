Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbTISKtj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 06:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbTISKtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 06:49:39 -0400
Received: from home.kvack.org ([216.138.200.138]:38831 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S261549AbTISKth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 06:49:37 -0400
Date: Fri, 19 Sep 2003 06:49:22 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Andi Kleen <ak@suse.de>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, Grant Grundler <iod00d@hp.com>,
       Peter Chubb <peterc@gelato.unsw.edu.au>, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-ID: <20030919064922.B3783@kvack.org>
References: <16234.33565.64383.838490@wombat.disy.cse.unsw.edu.au> <20030919043847.GA2996@cup.hp.com> <20030919044315.GC7666@wotan.suse.de> <16234.36238.848366.753588@wombat.chubb.wattle.id.au> <20030919055304.GE16928@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030919055304.GE16928@wotan.suse.de>; from ak@suse.de on Fri, Sep 19, 2003 at 07:53:04AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 19, 2003 at 07:53:04AM +0200, Andi Kleen wrote:
> You must add the 2 bytes in dev_alloc_skb() too.
> 
> (it also add 16 bytes by itself, but they are used for other things)

Sorry, the chipset does not support packet rx into unaligned buffers.  
stoopid.  Fwiw, the copy code got removed by davem -- isn't the core 
dealubg wuth unakugned packets now?

		-ben
-- 
"The software industry today survives only through an unstated agreement 
not to stir things up too much.  We must hope this lawsuit [by SCO] isn't 
the big stirring spoon." -- Ian Lance Taylor, Linux Journal, June 2003
