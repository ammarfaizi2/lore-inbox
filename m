Return-Path: <linux-kernel-owner+w=401wt.eu-S965077AbWLTOZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbWLTOZV (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 09:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWLTOZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 09:25:21 -0500
Received: from amsfep20-int.chello.nl ([62.179.120.15]:48994 "EHLO
	amsfep20-int.chello.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965077AbWLTOZU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 09:25:20 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: andrei.popa@i-neo.ro
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
In-Reply-To: <1166624117.6891.8.camel@localhost>
References: <1166314399.7018.6.camel@localhost>
	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>
	 <20061217154026.219b294f.akpm@osdl.org> <1166460945.10372.84.camel@twins>
	 <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	 <1166466272.10372.96.camel@twins>
	 <Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
	 <1166468651.6983.6.camel@localhost>
	 <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
	 <1166471069.6940.4.camel@localhost>
	 <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	 <1166571749.10372.178.camel@twins>  <1166624117.6891.8.camel@localhost>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 15:23:55 +0100
Message-Id: <1166624635.10372.229.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 16:15 +0200, Andrei Popa wrote:
> On Wed, 2006-12-20 at 00:42 +0100, Peter Zijlstra wrote:
> > On Mon, 2006-12-18 at 12:14 -0800, Linus Torvalds wrote:
> > 
> > > OR:
> > > 
> > >  - page_mkclean_one() is simply buggy.
> > 
> > GOLD!
> > 
> > it seems to work with all this (full diff against current git).
> > 
> > /me rebuilds full kernel to make sure...
> > reboot...
> > test...      pff the tension...
> > yay, still good!
> > 
> > Andrei; would you please verify.
> 
> I have corrupted files.

drad; and with this patch:
  http://lkml.org/lkml/2006/12/20/112

/me goes rebuild his kernel and try more than 3 times

