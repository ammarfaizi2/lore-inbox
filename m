Return-Path: <linux-kernel-owner+w=401wt.eu-S932706AbWLSJNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706AbWLSJNL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 04:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbWLSJNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 04:13:11 -0500
Received: from torres.zugschlus.de ([85.10.211.154]:2777 "EHLO
	torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932706AbWLSJNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 04:13:09 -0500
Date: Tue, 19 Dec 2006 10:13:05 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: Andrew Morton <akpm@osdl.org>
Cc: andrei.popa@i-neo.ro, Linus Torvalds <torvalds@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
Message-ID: <20061219091305.GB20442@torres.l21.ma.zugschlus.de>
References: <Pine.LNX.4.64.0612181426390.3479@woody.osdl.org> <1166485691.6977.6.camel@localhost> <Pine.LNX.4.64.0612181559230.3479@woody.osdl.org> <1166488199.6950.2.camel@localhost> <Pine.LNX.4.64.0612181648490.3479@woody.osdl.org> <20061218172126.0822b5d2.akpm@osdl.org> <1166492691.6890.12.camel@localhost> <20061218175449.3c752879.akpm@osdl.org> <1166515504.6897.0.camel@localhost> <20061219002416.ed8f1dda.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219002416.ed8f1dda.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 12:24:16AM -0800, Andrew Morton wrote:
> Wow.  I didn't expect that, because Mark Haber reported that ext3's data=writeback
> fixed it.   Maybe he didn't run it for long enough?

My test case is Debian's "aptitude update" running once an hour, and
it was always the same file getting corrupted. With 2.6.19, I had this
corruption like every third hour (but -only- if run from cron, running
from a shell was always fine), data=writeback made the issue disappear
for about two days before I booted into 2.6.19.1 without
data=writeback (defaults chosen then), after which the issue only
shows up like every other day.

So, I feel like out of the loop since rtorrent seems much better in
reproducing this.

I notice, though, that both aptitude and rtorrent do downloads from
the net, so there might be a relation to tcp/ip and/or the network
driver. My box has a Linksys NC100 network card running with the tulip
driver.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 621 72739835
