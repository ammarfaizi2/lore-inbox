Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932717AbWAFShp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932717AbWAFShp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbWAFSho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:37:44 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:10477 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932717AbWAFShn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:37:43 -0500
Date: Fri, 6 Jan 2006 10:37:33 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: Matthew Wilcox <matthew@wil.cx>, "Luck, Tony" <tony.luck@intel.com>,
       Arjan van de Ven <arjan@infradead.org>, hawkes@sgi.com,
       Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Dan Higgins <djh@sgi.com>,
       John Hesterberg <jh@sgi.com>, Greg Edwards <edwardsg@sgi.com>
Subject: Re: [PATCH] ia64: change defconfig to NR_CPUS==1024
In-Reply-To: <Pine.LNX.4.58.0601061017510.11324@shark.he.net>
Message-ID: <Pine.LNX.4.62.0601061035510.17875@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F055A7B6B@scsmsx401.amr.corp.intel.com>
 <20060106174957.GF19769@parisc-linux.org> <Pine.LNX.4.62.0601060958110.17665@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0601061017510.11324@shark.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Randy.Dunlap wrote:

> > The dicey thing in all of this is that the generic kernels will be used
> > for the certification of applications. If the cpu limit is too low then
> > applications will simply not be certified for these high processor counts.
> > One may encounter problems if the app is then run with a higher processor
> > count.
> 
> Do you equate a 'defconfig' kernel with a generic kernel?
> 
> I would expect certs to be done on vendor kernels, and as
> Arjan has suggested, they will have their own configs,
> not defconfig.

Vendors look for the upstream defaults and orient themselves on the 
defconfig. It is best to have as much common code and configurations as 
possible.

