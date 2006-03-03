Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752233AbWCCJom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbWCCJom (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 04:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752234AbWCCJol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 04:44:41 -0500
Received: from ns2.suse.de ([195.135.220.15]:61859 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752230AbWCCJol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 04:44:41 -0500
Date: Fri, 3 Mar 2006 10:44:30 +0100
From: Karsten Keil <kkeil@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>,
       i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 0/7] isdn4linux: add drivers for Siemens Gigaset ISDN DECT PABX
Message-ID: <20060303094430.GB31772@pingi.kke.suse.de>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Tilman Schmidt <tilman@imap.cc>, Hansjoerg Lipp <hjlipp@web.de>,
	i4ldeveloper@listserv.isdn4linux.de,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@suse.de>
References: <gigaset307x.2006.02.27.001.0@hjlipp.my-fqdn.de> <1141032577.2992.83.camel@laptopd505.fenrus.org> <440779AF.5060202@imap.cc> <1141368808.2883.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141368808.2883.16.camel@laptopd505.fenrus.org>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.13-15.7-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 07:53:28AM +0100, Arjan van de Ven wrote:
> On Fri, 2006-03-03 at 00:03 +0100, Tilman Schmidt wrote:
...
> 
> > >>+#define IFNULL(a) \
> > >>+       if (unlikely(!(a)))
> > > 
> > > please please get rid of this!
> > > (same goes for the variants of this just below this)
> > 
> > Ok, these were mainly debugging aids. We'll just drop them and let the
> > oops mechanism catch the (hopefully non-existent) remaining cases of
> > pointers being unexpectedly NULL.
> 
> you can also use WARN_ON() and BUG_ON() for that, you then get a more
> readable oops message (with filename and line information)
> 

Yes, but please only WARN_ON(), BUG_ON should be only used, if here is no
way to recover or if continue will cause major data corruption, I do not
think thats the case anywhere in the driver.

-- 
Karsten Keil
SuSE Labs
ISDN development
