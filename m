Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWDRL6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWDRL6a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 07:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWDRL63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 07:58:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21729 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932199AbWDRL62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 07:58:28 -0400
Date: Tue, 18 Apr 2006 12:58:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, James Morris <jmorris@namei.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060418115819.GB8591@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Gerrit Huizenga <gh@us.ibm.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serue@us.ibm.com>,
	Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	fireflier-devel@lists.sourceforge.net
References: <20060417225525.GA17463@infradead.org> <E1FVfGt-0003Wy-00@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FVfGt-0003Wy-00@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2006 at 06:44:51PM -0700, Gerrit Huizenga wrote:
> 
> On Mon, 17 Apr 2006 23:55:25 BST, Christoph Hellwig wrote:
> > On Mon, Apr 17, 2006 at 03:15:29PM -0700, Gerrit Huizenga wrote:
> > > configure correctly that most of them disable it.  In theory, LSM +
> > > something like AppArmour provides a much simpler security model for
> > 
> > apparmor falls into the findamentally broken category above, so it's
> > totally uninteresting except as marketing candy for the big red company.
> 
> Is there a pointer to why it is fundamentally broken?  I haven't seen
> such comments before but it may be that I've been hanging out on the
> wrong lists or spending too much time inhaling air at 30,000 feet.

It's doing access control on pathnames, which can't work in unix enviroments.
It's following the default permit behaviour which causes pain in anything
security-related (compare [1]).


[1] http://www.ranum.com/security/computer_security/editorials/dumb/
