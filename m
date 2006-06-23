Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWFWOME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWFWOME (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWFWOME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 10:12:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57004 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750734AbWFWOMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 10:12:03 -0400
Date: Fri, 23 Jun 2006 10:05:17 -0400 (EDT)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-5.boston.redhat.com
To: Arjan van de Ven <arjan@infradead.org>
cc: Robert Hancock <hancockr@shaw.ca>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: make PROT_WRITE imply PROT_READ
In-Reply-To: <1151071581.3204.14.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0606231002150.24102@dhcp83-5.boston.redhat.com>
References: <fa.PuMM6IwflUYh1MWILO9rb6z4fvY@ifi.uio.no>  <449B42B3.6010908@shaw.ca>
  <Pine.LNX.4.64.0606230934360.24102@dhcp83-5.boston.redhat.com>
 <1151071581.3204.14.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Jun 2006, Arjan van de Ven wrote:

> 
> > 
> > hi,
> > 
> > So if i create a PROT_WRITE only mapping and then read from first and then 
> > writte to it a get a SEGV. However, if i write to it first and then read 
> > from it, i don't get a SEGV...Why should the read/write ordering matter? 
> 
> it matters only on those cpus that don't have explicit/separate read
> permissions (just like PROT_EXEC is implied on cpus that don't have a
> special permission bit for that)...
> 
> 
> 

i understand that, but i'd like to see it changed so that i don't get a 
SEGV when i read first on those cpus. The current behavior, besides being 
inconsistent, is rather confusing...in addition, if ptes are copied 
instead of faulted i get yet another type of behavior...

-Jason

