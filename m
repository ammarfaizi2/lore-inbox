Return-Path: <linux-kernel-owner+w=401wt.eu-S932069AbWLSIYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWLSIYb (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 03:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbWLSIYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 03:24:31 -0500
Received: from smtp.osdl.org ([65.172.181.25]:36449 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932069AbWLSIYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 03:24:30 -0500
Date: Tue, 19 Dec 2006 00:24:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: andrei.popa@i-neo.ro
Cc: Linus Torvalds <torvalds@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
Message-Id: <20061219002416.ed8f1dda.akpm@osdl.org>
In-Reply-To: <1166515504.6897.0.camel@localhost>
References: <1166314399.7018.6.camel@localhost>
	<20061217040620.91dac272.akpm@osdl.org>
	<1166362772.8593.2.camel@localhost>
	<20061217154026.219b294f.akpm@osdl.org>
	<1166460945.10372.84.camel@twins>
	<Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	<1166466272.10372.96.camel@twins>
	<Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
	<1166468651.6983.6.camel@localhost>
	<Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
	<1166471069.6940.4.camel@localhost>
	<Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	<Pine.LNX.4.64.0612181230330.3479@woody.osdl.org>
	<1166476297.6862.1.camel@localhost>
	<Pine.LNX.4.64.0612181426390.3479@woody.osdl.org>
	<1166485691.6977.6.camel@localhost>
	<Pine.LNX.4.64.0612181559230.3479@woody.osdl.org>
	<1166488199.6950.2.camel@localhost>
	<Pine.LNX.4.64.0612181648490.3479@woody.osdl.org>
	<20061218172126.0822b5d2.akpm@osdl.org>
	<1166492691.6890.12.camel@localhost>
	<20061218175449.3c752879.akpm@osdl.org>
	<1166515504.6897.0.camel@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006 10:05:03 +0200
Andrei Popa <andrei.popa@i-neo.ro> wrote:

> > > > Also, it'd be useful if you could determine whether the bug appears with
> > > > the ext2 filesystem: do s/ext3/ext2/ in /etc/fstab, or boot with
> > > > rootfstype=ext2 if it's the root filesystem.
> > > 
>  I fave file corruption.

Wow.  I didn't expect that, because Mark Haber reported that ext3's data=writeback
fixed it.   Maybe he didn't run it for long enough?
