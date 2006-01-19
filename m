Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161069AbWASHQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069AbWASHQe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 02:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161070AbWASHQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 02:16:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47803 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161069AbWASHQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 02:16:33 -0500
Subject: Re: 2.6.16-rc1-mm1
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Reuben Farrelly <reuben-lkml@reub.net>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1137626021.1760.18.camel@localhost.localdomain>
References: <20060118005053.118f1abc.akpm@osdl.org>
	 <43CE2210.60509@reub.net> <20060118032716.7f0d9b6a.akpm@osdl.org>
	 <20060118190926.GB316@redhat.com>
	 <1137626021.1760.18.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 08:16:27 +0100
Message-Id: <1137654987.2993.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 23:13 +0000, Alan Cox wrote:
> On Mer, 2006-01-18 at 14:09 -0500, Dave Jones wrote:
> > On Wed, Jan 18, 2006 at 03:27:16AM -0800, Andrew Morton wrote:
> > 
> >  > Well yes, that code is kfree()ing a locked mutex.  It's somewhat weird to
> >  > take a lock on a still-private object but whatever.  The code's legal
> >  > enough.
> >  > 
> 
> If someone else can be waiting on it then it doesn't look legal ?

This is why Ingo made the decision to just declare it illegal period for
mutexes (and check for it in debug mode). The obvious exceptions are
error paths, but those aren't perf criticial in any way.


