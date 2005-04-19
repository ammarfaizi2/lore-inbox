Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVDSNYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVDSNYW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 09:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVDSNYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 09:24:22 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:64644 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261504AbVDSNYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 09:24:17 -0400
Date: Tue, 19 Apr 2005 09:24:17 -0400
To: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
Message-ID: <20050419132417.GS17865@csclub.uwaterloo.ca>
References: <20050419121530.GB23282@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050419121530.GB23282@schottelius.org>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 02:15:30PM +0200, Nico Schottelius wrote:
> When I wrote schwanz3(*) for fun, I noticed /proc/cpuinfo
> varies very much on different architectures.
> 
> Is it possible to make it look more identical (as far as the different
> archs allow it)?
> 
> So that one at least can count the cpus on every system the same way.
> 
> If so, who would the one I should contact and who would accept / verify
> a patch doing that?

If you change it now, how many tools would break?

Maybe if you can list what statistics you think should be common to all
systems, that could be presented in another file that is always the same
format on each architecture.

Certainly looking at arm and i386, other than the bogomips field there
is nothing in common between their cpuinfo contents.  THey don't even
capitalize bogomips the same either.

I doubt this is really doable.  If all you want is the number of CPUs
then something like sysconf(_SC_NPROCESSORS_CONF) should do.

Len Sorensen
