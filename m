Return-Path: <linux-kernel-owner+w=401wt.eu-S933058AbWLSXL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933058AbWLSXL0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 18:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933062AbWLSXL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 18:11:26 -0500
Received: from amsfep19-int.chello.nl ([62.179.120.14]:64188 "EHLO
	amsfep19-int.chello.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933058AbWLSXLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 18:11:23 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
In-Reply-To: <20061219145818.5b36381c.akpm@osdl.org>
References: <1166314399.7018.6.camel@localhost>
	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>
	 <20061217154026.219b294f.akpm@osdl.org> <1166460945.10372.84.camel@twins>
	 <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	 <45876C65.7010301@yahoo.com.au>
	 <Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>
	 <45878BE8.8010700@yahoo.com.au>
	 <Pine.LNX.4.64.0612182313550.3479@woody.osdl.org>
	 <Pine.LNX.4.64.0612182342030.3479@woody.osdl.org>
	 <4587B762.2030603@yahoo.com.au>
	 <Pine.LNX.4.64.0612190847270.3479@woody.osdl.org>
	 <Pine.LNX.4.64.0612190929240.3483@woody.osdl.org>
	 <Pine.LNX.4.64.0612191037291.3483@woody.osdl.org>
	 <1166563828.10372.162.camel@twins>
	 <Pine.LNX.4.64.0612191451410.3483@woody.osdl.org>
	 <20061219145818.5b36381c.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 00:06:22 +0100
Message-Id: <1166569582.10372.165.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-19 at 14:58 -0800, Andrew Morton wrote:

> Well... we'd need to see (corruption && this-not-triggering) to be sure.
> 
> Peter, have you been able to trigger the corruption?

Yes; however the mail I send describing that seems to be lost in space.

/me quotes from the send folder:

> The bad new is, that doesn't help either. The good news is I can
> reproduce it.
> 
> What I did to achieve that:
>  
>  - get a sizable torrent from legaltorrents.com / or create a torrent
> yourself that is around ~600M and has multiple files.
> 
>  - start a tracker, and multiple seeds (I used three machines here)
> 
>  - pull the torrent on a fourth machine
> 
> the seeding machines don't much matter of course.
> 
> the fourth machine was a dual core x86-64 with an SMP kernel and
> PREEMPT, mem=256M (so that the torrent is quite a bit larger and does
> require writeout) and I used an ext3 partition with 1k blocks.

