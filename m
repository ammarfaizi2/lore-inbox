Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752510AbWAFRYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbWAFRYj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 12:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbWAFRYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 12:24:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32904 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932733AbWAFRY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 12:24:29 -0500
Subject: RE: [PATCH] ia64: change defconfig to NR_CPUS==1024
From: Arjan van de Ven <arjan@infradead.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: hawkes@sgi.com, Tony Luck <tony.luck@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jack Steiner <steiner@sgi.com>,
       Dan Higgins <djh@sgi.com>, John Hesterberg <jh@sgi.com>,
       Greg Edwards <edwardsg@sgi.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F055A7AFB@scsmsx401.amr.corp.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F055A7AFB@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 18:24:16 +0100
Message-Id: <1136568256.2940.50.camel@laptopd505.fenrus.org>
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

On Fri, 2006-01-06 at 09:19 -0800, Luck, Tony wrote:
> >> Increase the generic ia64 config from its current max of 512 CPUs to a
> >> new max of 1024 CPUs.
> >
> >I wonder why this would be seen as a sane thing...
> >Very few people have 1024 cpus, and the ones that do sure would know how
> >to set 1024 in their kernel config. In fact I would argue to lower it. I
> >can see the point of keeping it over 64, to give the
> >more-cpus-than-a-long code more testing, but 512 is too high already..
> >most people who have ia64 will not have 512 cpus.
> 
> Would it be impossibly hard to make the >64 cpus case (when the code
> switches from a single word to an array) be dependent on a boot-time
> variable?  If we could, then the defconfig could just say 128, and
> users of monster machines would just boot with "maxcpus=4096" to increase
> the size of the bitmask arrays.

variable size runtime cpu count.. that's beside the point for this
change though. The *default* shouldn't be insanely high, but more
represent a "typical" setup. The *maximum* is of course an entirely
different thing. So.. I'd say lower the default from 512 to 128 (just to
get the default to be the "complex case", which has benefits). Going to
1024 for a per user default is silly. Just about everyone will change it
anyway to something lower. And distros set their own regardless.


