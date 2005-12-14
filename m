Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbVLNLIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbVLNLIj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 06:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVLNLIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 06:08:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:167 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932399AbVLNLIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 06:08:38 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Howells <dhowells@redhat.com>,
       Christopher Friesen <cfriesen@nortel.com>, torvalds@osdl.org,
       akpm@osdl.org, hch@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
In-Reply-To: <1134558188.25663.5.camel@localhost.localdomain>
References: <439EDC3D.5040808@nortel.com>
	 <1134479118.11732.14.camel@localhost.localdomain>
	 <dhowells1134431145@warthog.cambridge.redhat.com>
	 <3874.1134480759@warthog.cambridge.redhat.com>
	 <15167.1134488373@warthog.cambridge.redhat.com>
	 <1134490205.11732.97.camel@localhost.localdomain>
	 <1134556187.2894.7.camel@laptopd505.fenrus.org>
	 <1134558188.25663.5.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 12:08:27 +0100
Message-Id: <1134558507.2894.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 11:03 +0000, Alan Cox wrote:
> On Mer, 2005-12-14 at 11:29 +0100, Arjan van de Ven wrote:
> > > >      But this means that the current usages all have to be carefully audited,
> > > >      and sometimes that unobvious.
> > > 
> > > Only if you insist on replacing them immediately. If you submit a
> > > *small* patch which just adds the new mutexes then a series of small
> > > patches can gradually convert code where mutexes are better. 
> > 
> > this unfortunately is not very realistic in practice... 
> 
> Strange because it is how most such work has been done in the past, from
> the big kernel lock to the scsi core rewrite.

1) the BKL change hasn't finished, and we're 5 years down the line. API
changes done gradual tend to take forever in practice, esp if there's no
"compile" incentive for people to fix things. 

2) the scsi rewrite was a major functional change. that's different from
a basically pure API change (split). Splitting functional changes to one
part of the kernel up into a sequence is very good. THat's different
though: even in the scsi change, API changes that went outside the scsi
core into the drivers were mostly done in one bang (not all of them, the
ones that weren't ended up being rather painful)


>  You also forgot to attach
> a reason you think it isnt realistic ?
> 
that was in a follow up email


