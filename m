Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVGFIOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVGFIOj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 04:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVGFIOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 04:14:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39324 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262129AbVGFGfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 02:35:11 -0400
Subject: Re: Tracking a bug in x86-64
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Bongani Hlope <bonganilinux@mweb.co.za>, rudsve@drewag.de,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, mingo@elte.hu,
       Little.Boss@physics.mcgill.ca
In-Reply-To: <20050705141234.3cab3328.akpm@osdl.org>
References: <200506132259.22151.bonganilinux@mweb.co.za>
	 <200506160139.04389.bonganilinux@mweb.co.za>
	 <xfkll4lfy41.fsf@uxkm53.drewag.de>
	 <200507052152.24022.bonganilinux@mweb.co.za>
	 <20050705141234.3cab3328.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 06 Jul 2005 08:34:55 +0200
Message-Id: <1120631696.3168.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-05 at 14:12 -0700, Andrew Morton wrote:
> Bongani Hlope <bonganilinux@mweb.co.za> wrote:
> >
> > I haven't tested 2.6.12.2 but the problem was introduced around 2.6.11-mm1 and
> >  found its way to 2.6.12-rcX. First try to run the following command (this works for me)
> >  echo 0 > /proc/sys/kernel/randomize_va_space
> >  I got an email from Juan Gallego (cc'd), he says that command does not work for him though.
> > 
> >  Andrew,
> >  Should I log this on the kernel's bugzilla?
> 
> Yes please.  This is a tough one, and having one place to go to for the
> info would be useful.

key for this one is to make sure we separate the cases carefully, and
not end up with one big bucket of "something broke" that has a gazilion
different and unrelated causes. 
For the cases where a vm layout thing is suspected of causing the
breakage we also really need a /proc/<pid>/maps *at the time of the
breakage* realistically for doing any kind of diagnostics.


