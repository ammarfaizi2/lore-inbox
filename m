Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965176AbWGFJek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbWGFJek (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 05:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965179AbWGFJek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 05:34:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8654 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965176AbWGFJek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 05:34:40 -0400
Subject: Re: [patch] spinlocks: remove 'volatile'
From: Arjan van de Ven <arjan@infradead.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060706092703.GB9416@osiris.boeblingen.de.ibm.com>
References: <20060705101059.66a762bf.akpm@osdl.org>
	 <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org>
	 <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org>
	 <20060705204727.GA16615@elte.hu>
	 <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org>
	 <20060705214502.GA27597@elte.hu>
	 <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org>
	 <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
	 <20060706081639.GA24179@elte.hu>
	 <20060706092703.GB9416@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 11:34:31 +0200
Message-Id: <1152178471.3084.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Shouldn't the __raw_read_can_lock and __raw_write_can_lock macros be changed too, just
> to make sure the value gets read every single time if it's used in a loop?
> Just like the __raw_spin_is_locked already has a (volatile signed char * cast)?
> -

it shouldn't get a volatile case imo, just a barrier().
A barrier() at least has well defined semantics, unlike volatile...


