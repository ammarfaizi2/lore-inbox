Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265776AbRGCSnZ>; Tue, 3 Jul 2001 14:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265778AbRGCSnQ>; Tue, 3 Jul 2001 14:43:16 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:65189 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S265776AbRGCSnF>; Tue, 3 Jul 2001 14:43:05 -0400
Date: Tue, 3 Jul 2001 19:43:00 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Timur Tabi <ttabi@interactivesi.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: pte_val(*pte) as lvalue
Message-ID: <20010703194300.A31954@flint.arm.linux.org.uk>
In-Reply-To: <9LUWoC.A.W3G.sIQQ7@dinero.interactivesi.com.suse.lists.linux.kernel> <oupelryykh5.fsf@pigdrop.muc.suse.de> <LScPx.A.XAF.H_gQ7@dinero.interactivesi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <LScPx.A.XAF.H_gQ7@dinero.interactivesi.com>; from ttabi@interactivesi.com on Tue, Jul 03, 2001 at 01:32:36PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2001 at 01:32:36PM -0500, Timur Tabi wrote:
> ** Reply to message from Andi Kleen <ak@suse.de> on 03 Jul 2001 01:33:42 +0200
> > set_pte(pte, mk_pte( ... )) 
> 
> I'm not sure how to use mk_pte.  The first parameter is a struct page *,
> which I don't have.  All I'm doing is modifying the PTE value.  I don't
> want to "make" another one.

set_pte is the only way you can guarantee that the architecture
implementation gets to do what it needs to do with the PTE value
before stuffing it into the PTE tables.

Can I ask what the nature of the PTE modification is, and where you
are making this modification?

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

