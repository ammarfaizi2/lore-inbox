Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161253AbWG1TxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161253AbWG1TxY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 15:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbWG1TxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 15:53:24 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:28858 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1030301AbWG1TxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 15:53:24 -0400
Subject: Re: [patch 5/5] Add the -fstack-protector option to the CFLAGS
From: Arjan van de Ven <arjan@linux.intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <200607282100.01783.ak@suse.de>
References: <1154102546.6416.9.camel@laptopd505.fenrus.org>
	 <200607282045.05292.ak@suse.de>
	 <1154112511.6416.46.camel@laptopd505.fenrus.org>
	 <200607282100.01783.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 21:53:03 +0200
Message-Id: <1154116384.6416.52.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 21:00 +0200, Andi Kleen wrote:
> On Friday 28 July 2006 20:48, Arjan van de Ven wrote:
> > On Fri, 2006-07-28 at 20:45 +0200, Andi Kleen wrote:
> > > > +ifdef CONFIG_CC_STACKPROTECTOR
> > > > +CFLAGS += $(call cc-ifversion, -lt, 0402, -fno-stack-protector)
> > > > +CFLAGS += $(call cc-ifversion, -ge, 0402, -fstack-protector)
> > >
> > > Why can't you just use the normal call cc-option for this?
> >
> > this requires gcc 4.2; cc-option is not useful for that.
> 
> This means nearly nobody can use it.

... today.

>  The CC option thing is also
> very ugly. 

It's what Sam suggested as kbuild guy.

>  Perhaps you really need a Makefile time check like
> configure would do for it. Generating a .s and grepping for %gs 
> would be enough I guess.
> 


Sam?

