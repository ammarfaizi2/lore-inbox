Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVBOJRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVBOJRK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 04:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVBOJRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 04:17:10 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:28110 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261656AbVBOJRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 04:17:05 -0500
Message-ID: <4211BD88.70904@sgi.com>
Date: Tue, 15 Feb 2005 03:14:48 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: ak@muc.de, holt@sgi.com, marcelo.tosatti@cyclades.com,
       raybry@austin.rr.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>	<m1vf8yf2nu.fsf@muc.de>	<20050212155426.GA26714@logos.cnet>	<20050212212914.GA51971@muc.de>	<20050214163844.GB8576@lnx-holt.americas.sgi.com>	<20050214191509.GA56685@muc.de>	<42113921.7070807@sgi.com> <20050214191651.64fc3347.pj@sgi.com>
In-Reply-To: <20050214191651.64fc3347.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Ray wrote:
> 
>>[Thus the disclaimer in
>>the overview note that we have figured all the interaction with
>>memory policy stuff yet.]
> 
> 
> Does the same disclaimer apply to cpusets?
> 
> Unless it causes some undo pain, I would think that page migration
> should _not_ violate a tasks cpuset.  I guess this means that a typical
> batch manager would move a task to its new cpuset on the new nodes, or
> move the cpuset containing some tasks to their new nodes, before asking
> the page migrator to drag along the currently allocated pages from the
> old location.
> 
No, I think we understand the interaction between manual page migration
and cpusets.  We've tried to keep the discussion here disjoint from cpusets
for tactical reasons -- we didn't want to tie acceptance of the manual
page migration code to acceptance of cpusets.

The exact ordering of when a task is moved to a new cpuset and when the
migration occurs doesn't matter, AFAIK, if we accept the notion that
a migrated task is in suspended state until after everything associated
with it (including the new cpuset definition) is done.

-- 
-----------------------------------------------
Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
	 so I installed Linux.
-----------------------------------------------
