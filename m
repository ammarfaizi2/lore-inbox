Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262882AbTCSBqj>; Tue, 18 Mar 2003 20:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262884AbTCSBqj>; Tue, 18 Mar 2003 20:46:39 -0500
Received: from ns.suse.de ([213.95.15.193]:55825 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262882AbTCSBqj>;
	Tue, 18 Mar 2003 20:46:39 -0500
Date: Wed, 19 Mar 2003 02:55:17 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: andrea@suse.de, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: 2.4 delayed acks don't work, fixed
Message-ID: <20030319015517.GA15150@wotan.suse.de>
References: <20030318221906.GA30541@dualathlon.random> <200303182235.BAA05440@sex.inr.ac.ru> <20030319002409.GI30541@dualathlon.random> <20030318.163701.56035556.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030318.163701.56035556.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This streamer application should buffer at the sending side, in order
> to keep the window full.  Introducing artificial delays on the sending
> side of a unidirectional TCP transfer is really bad for performance
> and I can assure you that more than just "weird delayed ACK" behavior
> will result.

The broken tail append patch I did some time ago was supposed to address 
that (better merging of writes on the sender side even for non SG
NICs). Perhaps it should be rechecked.

It may fix this.

-Andi
