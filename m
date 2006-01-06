Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752568AbWAFVBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbWAFVBA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752567AbWAFVBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:01:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17128 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752565AbWAFVA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:00:59 -0500
Date: Fri, 6 Jan 2006 16:00:24 -0500
From: Dave Jones <davej@redhat.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Matthew Wilcox <matthew@wil.cx>,
       "Luck, Tony" <tony.luck@intel.com>,
       Arjan van de Ven <arjan@infradead.org>, hawkes@sgi.com,
       Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Dan Higgins <djh@sgi.com>,
       John Hesterberg <jh@sgi.com>, Greg Edwards <edwardsg@sgi.com>
Subject: Re: [PATCH] ia64: change defconfig to NR_CPUS==1024
Message-ID: <20060106210024.GK4595@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Christoph Lameter <clameter@engr.sgi.com>,
	"Randy.Dunlap" <rdunlap@xenotime.net>,
	Matthew Wilcox <matthew@wil.cx>, "Luck, Tony" <tony.luck@intel.com>,
	Arjan van de Ven <arjan@infradead.org>, hawkes@sgi.com,
	Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jack Steiner <steiner@sgi.com>, Dan Higgins <djh@sgi.com>,
	John Hesterberg <jh@sgi.com>, Greg Edwards <edwardsg@sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F055A7B6B@scsmsx401.amr.corp.intel.com> <20060106174957.GF19769@parisc-linux.org> <Pine.LNX.4.62.0601060958110.17665@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0601061017510.11324@shark.he.net> <Pine.LNX.4.62.0601061035510.17875@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0601061035510.17875@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 10:37:33AM -0800, Christoph Lameter wrote:
 > On Fri, 6 Jan 2006, Randy.Dunlap wrote:
 > 
 > > > The dicey thing in all of this is that the generic kernels will be used
 > > > for the certification of applications. If the cpu limit is too low then
 > > > applications will simply not be certified for these high processor counts.
 > > > One may encounter problems if the app is then run with a higher processor
 > > > count.
 > > 
 > > Do you equate a 'defconfig' kernel with a generic kernel?
 > > 
 > > I would expect certs to be done on vendor kernels, and as
 > > Arjan has suggested, they will have their own configs,
 > > not defconfig.
 > 
 > Vendors look for the upstream defaults and orient themselves on the 
 > defconfig. It is best to have as much common code and configurations as 
 > possible.

As someone who builds vendor kernels, I can say this isn't true (from my
experience at least).  When a new config option appears, I look at the
Kconfig, and make a decision.  I *never* even look at the defconfig, as
a lot of the time, they are either out of date, or irrelevant.

		Dave

