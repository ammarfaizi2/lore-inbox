Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbTIKWNr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 18:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbTIKWNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 18:13:47 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:55955 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261526AbTIKWNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 18:13:45 -0400
Subject: Re: [RFC][PATCH] kmalloc + memset(foo, 0, bar) = kmalloc0
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Jamie Lokier <jamie@shareable.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030911215805.GA7221@werewolf.able.es>
References: <200309111540.58729@bilbo.math.uni-mannheim.de>
	 <20030911134557.GV454@parcelfarce.linux.theplanet.co.uk>
	 <20030911170944.GG29532@mail.jlokier.co.uk>
	 <20030911215805.GA7221@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063318342.3886.17.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Thu, 11 Sep 2003 23:12:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-09-11 at 22:58, J.A. Magallon wrote:
> On 09.11, Jamie Lokier wrote:
> > viro@parcelfarce.linux.theplanet.co.uk wrote:
> > > Bad choice of name - too easy to confuse with kmalloc().
> > 
> > kmalloc_and_zero() would be much clearer.
> > 
> 
> Why not kcalloc() ?

A kcalloc that also checked for maths overflows would probably
help avoid various errors and checks against ~0/sizeof(n) in
drivers we have now

