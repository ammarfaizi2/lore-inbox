Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264797AbTFUOud (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 10:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264830AbTFUOud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 10:50:33 -0400
Received: from zork.zork.net ([64.81.246.102]:8640 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S264797AbTFUOuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 10:50:32 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Isapnp warning
References: <Pine.GSO.4.21.0306211658470.869-100000@vervain.sonytel.be>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sat, 21 Jun 2003 16:04:35 +0100
In-Reply-To: <Pine.GSO.4.21.0306211658470.869-100000@vervain.sonytel.be> (Geert
 Uytterhoeven's message of "Sat, 21 Jun 2003 16:59:38 +0200 (MEST)")
Message-ID: <6uadcbcvzw.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On 21 Jun 2003, Alan Cox wrote:
>> On Sul, 2003-06-15 at 19:36, Geert Uytterhoeven wrote:
>> > Isapnp: Kill warning if CONFIG_PCI is not set
>> > 
>> > --- linux-2.5.x/drivers/pnp/resource.c	Tue May 27 19:03:04 2003
>> > +++ linux-m68k-2.5.x/drivers/pnp/resource.c	Sun Jun  8 13:31:20 2003
>> > @@ -97,7 +97,9 @@
>> >  
>> >  int pnp_add_irq_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data)
>> >  {
>> > +#ifdef CONFIG_PCI
>> >  	int i;
>> > +#endif
>> 
>> This is far uglier than te warning
>
> It depends on your goals. These warnings distract us from the real harmful
> warnings. Will we ever have a kernel that compiles with -Werror?

Unless GCC never emits an invalid warning, no.

