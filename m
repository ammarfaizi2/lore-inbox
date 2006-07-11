Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWGKSiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWGKSiM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWGKSiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:38:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:19842 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932084AbWGKSiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:38:09 -0400
Date: Tue, 11 Jul 2006 11:37:54 -0700
From: Jeremy Higdon <jeremy@sgi.com>
To: David Mosberger-Tang <David.Mosberger@acm.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Jes Sorensen <jes@sgi.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Luck, Tony" <tony.luck@intel.com>,
       John Daiker <jdaiker@osdl.org>, John Hawkes <hawkes@sgi.com>,
       Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Dan Higgins <djh@sgi.com>
Subject: Re: [PATCH] ia64: change usermode HZ to 250
Message-ID: <20060711183754.GB734242@sgi.com>
References: <617E1C2C70743745A92448908E030B2A27FC5F@scsmsx411.amr.corp.intel.com> <yq04py4i9p7.fsf@jaguar.mkp.net> <1151578928.23785.0.camel@localhost.localdomain> <44A3AFFB.2000203@sgi.com> <1151578513.3122.22.camel@laptopd505.fenrus.org> <20060708001427.GA723842@sgi.com> <1152340963.3120.0.camel@laptopd505.fenrus.org> <ed5aea430607080607u67aeb05di963243c0e653e4f0@mail.gmail.com> <20060710202228.GA732959@sgi.com> <ed5aea430607102001g514bfa97jf82c25a038e9c436@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed5aea430607102001g514bfa97jf82c25a038e9c436@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 09:01:53PM -0600, David Mosberger-Tang wrote:
> Note that Alan didn't claim that *all* (Linux-supported) architectures
> expose a constant user HZ, only the "mainstream" ones.  I won't get
> into the debate as to what qualifies as "mainstream", but clearly IA64
> does not (and should not) expose a constant value, since there were no
> legacy-binary-issue and we chose to insist that apps should uses
> sysconf() or equivalent if they need to know the clocktick.
> 
>  --david


Okay.  So what do you think about changing the value in param.h from
1024, so that it matches the new common value of 250, or is it best
just to leave it at 1024 and let applications that use it get the wrong
result?

jeremy
