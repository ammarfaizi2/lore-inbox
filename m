Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266073AbUGVPCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266073AbUGVPCf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 11:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266208AbUGVPCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 11:02:34 -0400
Received: from ip-213-226-226-138.ji.cz ([213.226.226.138]:46295 "HELO
	machine.sinus.cz") by vger.kernel.org with SMTP id S266073AbUGVPCN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 11:02:13 -0400
Date: Thu, 22 Jul 2004 17:02:11 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Tim Connors <tconnors+linuxkernel1090478761@astro.swin.edu.au>
Cc: Dale Fountain <dpf-lkml@fountainbay.com>, Andrew Morton <akpm@osdl.org>,
       jmorris@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Re:  [PATCH] Delete cryptoloop
Message-ID: <20040722150211.GP5517@pasky.ji.cz>
Mail-Followup-To: Tim Connors <tconnors+linuxkernel1090478761@astro.swin.edu.au>,
	Dale Fountain <dpf-lkml@fountainbay.com>,
	Andrew Morton <akpm@osdl.org>, jmorris@redhat.com,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com> <20040721230044.20fdc5ec.akpm@osdl.org> <4411.24.6.231.172.1090470409.squirrel@24.6.231.172> <20040722014649.309bc26f.akpm@osdl.org> <4546.24.6.231.172.1090476838.squirrel@24.6.231.172> <slrn-0.9.7.4-8073-28820-200407221646-tc@hexane.ssi.swin.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrn-0.9.7.4-8073-28820-200407221646-tc@hexane.ssi.swin.edu.au>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Thu, Jul 22, 2004 at 08:47:28AM CEST, I got a letter,
where Tim Connors <tconnors+linuxkernel1090478761@astro.swin.edu.au> told me, that...
> "Dale Fountain" <dpf-lkml@fountainbay.com> said on Wed, 21 Jul 2004 23:13:58 -0700 (PDT):
> > Dm-crypt is still unstable, doesn't have all the features of cryptoloop
> > (please see my previous message), yet you wish to dump cryptoloop? At
> > least cryptoloop is a known quantity.
> > 
> > Once dm-crypt can be shown to have all the features of the software it's
> > meant to _replace_, I'll be more likely to agree. Otherwise, it sounds
> > like this decision is being made on a whim.
> 
> *cough* devfs->udev *cough*
> 
> I'm such a bastard :)

Judging from the discussion, this is really a different case. udev is
known to be already quite mature and fully replaces devfs - dm-crypt
being still quite a new player and not able to fully replace cryptoloop
yet.  So people who cannot replace cryptoloop with dm-crypt yet should
wait with upgrading from 2.6.8, backporting security fixes manually?

Another difference is that having devfs around means holding off the
drivers development globally and removing it would clean the code up a
lot - there is no such thing with removing cryptoloop, AFAIK. And I
don't buy the argument that it will encourage dm-crypt development - if
it suffers from a lack of developers interest, something else is
apparently wrong (there is either no that big need for moving away from
cryptoloop or the advantages don't balance the change effort for most
people) and forcing *users* to it won't help much; that works around the
natural selection by centralized control.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
For every complex problem there is an answer that is clear, simple,
and wrong.  -- H. L. Mencken
