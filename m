Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVDRUHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVDRUHg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 16:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVDRUHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 16:07:36 -0400
Received: from warsl404pip7.highway.telekom.at ([195.3.96.91]:27666 "EHLO
	email.aon.at") by vger.kernel.org with ESMTP id S262196AbVDRUHQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 16:07:16 -0400
Date: Mon, 18 Apr 2005 22:07:12 +0200
From: Bernhard Fischer <blist@aon.at>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Timur Tabi <timur.tabi@ammasso.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050418200711.GI15688@aon.at>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com> <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com> <4263DBBF.9040801@ammasso.com> <1113840973.6274.84.camel@laptopd505.fenrus.org> <4263DF70.2060702@ammasso.com> <1113853240.6274.99.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113853240.6274.99.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 09:40:40PM +0200, Arjan van de Ven wrote:
>On Mon, 2005-04-18 at 11:25 -0500, Timur Tabi wrote:
>> Arjan van de Ven wrote:
>> 
>> > this is a myth; linux is free to move the page about in physical memory
>> > even if it's mlock()ed!!
darn, yes, this is true.
I know people who introduced
#define VM_RESERVED     0x00080000      /* Don't unmap it from swap_out
*/
to vm_flags just because of this. I'll just hold my breath and won't
delve further.
>> 
>> Then Linux has a very odd definition of the word "locked".
>> 
>> > And even then, the user can munlock the memory from another thread etc
>> > etc. Not a good idea.
>> 
>> Well, that's okay, because then the app is doing something stupid, so we don't worry about 
>> that.
>
>you should since that physical page can be reused, say by a root
>process, and you'd be majorly screwed
