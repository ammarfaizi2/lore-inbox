Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264732AbUD2OsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264732AbUD2OsM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 10:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264700AbUD2OsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 10:48:12 -0400
Received: from florence.buici.com ([206.124.142.26]:53127 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264732AbUD2OsG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 10:48:06 -0400
Date: Thu, 29 Apr 2004 07:48:04 -0700
From: Marc Singer <elf@buici.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: brettspamacct@fastclick.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040429144804.GB708@buici.com>
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com> <40905127.3000001@fastclick.com> <4090CE3D.2010106@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4090CE3D.2010106@aitel.hist.no>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 11:43:25AM +0200, Helge Hafting wrote:
> Brett E. wrote:
> [...]
> >Or how about "Use ALL the cache you want Mr. Kernel.  But when I want 
> >more physical memory pages, just reap cache pages and only swap out when 
> >the cache is down to a certain size(configurable, say 100megs or 
> >something)."
> 
> Problem: reaping cache is equivalent to swapping in some cases.
> The cache isn't merely "files read & written".
> It is also all your executable code.  Code is not different from
> files being read at all.  Dumping too much cache will dump the
> code you're executing, and then it have to be reloaded from disk.

Hmm.  I was under the impression that mapped pages were code and
unmapped pages were IO page cache.  Are you suggesting that code is
duplicated?

