Return-Path: <linux-kernel-owner+w=401wt.eu-S1753646AbWLRKAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646AbWLRKAU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 05:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753695AbWLRKAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 05:00:19 -0500
Received: from [85.204.20.254] ([85.204.20.254]:57324 "EHLO megainternet.ro"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753645AbWLRKAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 05:00:17 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Andrei Popa <andrei.popa@i-neo.ro>
Reply-To: andrei.popa@i-neo.ro
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
In-Reply-To: <20061218013806.2cf67614.akpm@osdl.org>
References: <1166314399.7018.6.camel@localhost>
	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>
	 <20061217154026.219b294f.akpm@osdl.org>
	 <Pine.LNX.4.64.0612171716510.3479@woody.osdl.org>
	 <Pine.LNX.4.64.0612171725110.3479@woody.osdl.org>
	 <Pine.LNX.4.64.0612171744360.3479@woody.osdl.org>
	 <45861E68.3060403@yahoo.com.au>
	 <Pine.LNX.4.64.0612172145250.3479@woody.osdl.org>
	 <1166433544.6911.5.camel@localhost> <20061218013806.2cf67614.akpm@osdl.org>
Content-Type: text/plain
Organization: I-NEO
Date: Mon, 18 Dec 2006 12:00:05 +0200
Message-Id: <1166436005.7072.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-18 at 01:38 -0800, Andrew Morton wrote: 
> On Mon, 18 Dec 2006 11:19:04 +0200
> Andrei Popa <andrei.popa@i-neo.ro> wrote:
> 
> > 
> > I tried latest git with the patch from this email and it still get file
> > content corruption. If I can help you further debug the problem tell me
> > what to do.
> 
> Can you please tell us all the steps which we need to take to reproduce this?

I'm using rtorrent-0.7.0 and libtorrent-0.11.0, just download a torrent
with multiple files(I downloaded 84 rar files) and when it will finish
it will do a hash check and at the end of the check will say "Hash check
on download completion found bad chunks, consider using "safe_sync"."
and stop and most of the downloaded files are broken. With Peter
Zijlstra patch this error doesn't show but there is file
corruption(although less files are corrupted); afther the hash check,
rtorrent will download the bad chunks and do another hash check and all
files are ok.

