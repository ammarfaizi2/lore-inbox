Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWDSIRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWDSIRy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 04:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWDSIRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 04:17:54 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:22948 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750760AbWDSIRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 04:17:53 -0400
Date: Wed, 19 Apr 2006 10:16:46 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Greg KH <greg@kroah.com>
cc: James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation
 of LSM hooks)
In-Reply-To: <20060417195146.GA8875@kroah.com>
Message-ID: <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
References: <200604021240.21290.edwin@gurde.com> <200604072138.35201.edwin@gurde.com>
 <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil>
 <200604142301.10188.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
 <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
 <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei>
 <20060417195146.GA8875@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Seriously that makes a lot of sense.  All other modules people have come up
>> > with over the last years are irrelevant and/or broken by design.
>> 
>> It's been nearly a year since I proposed this, and we've not seen any 
>> appropriate LSM modules submitted in that time.
>> 
>> See
>> http://thread.gmane.org/gmane.linux.kernel.lsm/1120
>> http://thread.gmane.org/gmane.linux.kernel.lsm/1088
>> 
>> The only reason I can see to not delete it immediately is to give BSD 
>> secure levels users a heads-up, although I thought it was already slated 
>> for removal.  BSD secure levels is fundamentally broken and should 
>> never have gone into mainline.
>
>been a very long time and so far, only out-of-tree LSMs are present,
>with no public statements about getting them submitted into the main
>kernel tree.  And, I think almost all of the out-of-tree modules already
>need other kernel patches to get their code working properly, so what's
>a few more hooks needed...
>
>/me pokes the bushes to flush out the people lurking
>

Well then, have a look at http://alphagate.hopto.org/multiadm/

There is a reason to why people [read: I] do not submit out-of-tree (OOT)
modules; because I think chances are low that they get in. Sad fact about the
Linux kernel.

>Oh, but do remember, the main goal of LSM was to stop people from
>arguing about different security models.  Now that it is in, we haven't
>had any bickering about different types of things that should go into
>mainline, all with different models and usages.  Everyone gets to play
>in their own sandbox and not worry about anyone else.  If the LSM
>interface was to go away, that problem would start happening again, and
>I don't think we want to go there.
>
>So, I think the only way to be able to realisticly keep the LSM
>interface, is for a valid, working, maintained LSM-based security model
>to go into the kernel tree.  So far, I haven't seen any public posting
>of patches that meet this requirement :(

In that case, maybe it would be worthwhile to flip the positions, i.e. LSM on
top of SELinux, sort of a compat layer.



Jan Engelhardt
-- 
