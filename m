Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318134AbSHLPl1>; Mon, 12 Aug 2002 11:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318138AbSHLPl0>; Mon, 12 Aug 2002 11:41:26 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:62213 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318134AbSHLPl0>; Mon, 12 Aug 2002 11:41:26 -0400
Date: Mon, 12 Aug 2002 16:45:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Alexandre Julliard <julliard@winehq.com>,
       Luca Barbieri <ldb@ldb.ods.org>
Subject: Re: [patch] tls-2.5.31-D7
Message-ID: <20020812164512.A8292@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org,
	Alexandre Julliard <julliard@winehq.com>,
	Luca Barbieri <ldb@ldb.ods.org>
References: <Pine.LNX.4.44.0208121858280.21637-100000@localhost.localdomain> <Pine.LNX.4.44.0208121920250.22188-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208121920250.22188-100000@localhost.localdomain>; from mingo@elte.hu on Mon, Aug 12, 2002 at 07:24:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 07:24:25PM +0200, Ingo Molnar wrote:
> the attached patch does this:
> 
>  - there are now 4 freely usable TLS entries, amongst them 0x40 for Wine
> 
>  - the 3 APM segments fit into the hole at the end of the kernel
>    descriptor area exactly => no GDT size increase.
> 
>  - the ->private_tls code is gone - unconditional inline copies are more
>    robust and faster as well.
> 
> Plus the APM code needs Stephen's fix. I think this is the best approach
> we had so far. Any objections?

Patch looks good so far, but _please_ rename struct modify_ldt_ldt_s to
something more sensible. (yes, I know it existed before, but with this
patch the name is even more stupid than before)

