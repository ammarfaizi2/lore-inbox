Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVDUJ67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVDUJ67 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 05:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVDUJ67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 05:58:59 -0400
Received: from extgw-uk.mips.com ([62.254.210.129]:39441 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S261242AbVDUJ6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 05:58:42 -0400
Date: Wed, 20 Apr 2005 21:31:09 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
Message-ID: <20050420203109.GB4551@linux-mips.org>
References: <20050419121530.GB23282@schottelius.org> <20050419132417.GS17865@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050419132417.GS17865@csclub.uwaterloo.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 09:24:17AM -0400, Lennart Sorensen wrote:

> If you change it now, how many tools would break?
> 
> Maybe if you can list what statistics you think should be common to all
> systems, that could be presented in another file that is always the same
> format on each architecture.
> 
> Certainly looking at arm and i386, other than the bogomips field there
> is nothing in common between their cpuinfo contents.  THey don't even
> capitalize bogomips the same either.
> 
> I doubt this is really doable.  If all you want is the number of CPUs
> then something like sysconf(_SC_NPROCESSORS_CONF) should do.

Which in glibc is implemented by counting the number of processor: records
in /proc/cpuinfo, so simply Nico's parser seems to be insufficient.

  Ralf
