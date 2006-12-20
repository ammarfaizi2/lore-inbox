Return-Path: <linux-kernel-owner+w=401wt.eu-S1030196AbWLTQam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWLTQam (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 11:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbWLTQam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 11:30:42 -0500
Received: from [85.204.20.254] ([85.204.20.254]:49222 "EHLO megainternet.ro"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030196AbWLTQam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 11:30:42 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Andrei Popa <andrei.popa@i-neo.ro>
Reply-To: andrei.popa@i-neo.ro
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
In-Reply-To: <1166624635.10372.229.camel@twins>
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
	 <1166624635.10372.229.camel@twins>
Content-Type: text/plain
Organization: I-NEO
Date: Wed, 20 Dec 2006 18:30:34 +0200
Message-Id: <1166632234.7654.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 15:23 +0100, Peter Zijlstra wrote:
> On Wed, 2006-12-20 at 16:15 +0200, Andrei Popa wrote:
> > On Wed, 2006-12-20 at 00:42 +0100, Peter Zijlstra wrote:
> > > On Mon, 2006-12-18 at 12:14 -0800, Linus Torvalds wrote:
> > > 
> > > > OR:
> > > > 
> > > >  - page_mkclean_one() is simply buggy.
> > > 
> > > GOLD!
> > > 
> > > it seems to work with all this (full diff against current git).
> > > 
> > > /me rebuilds full kernel to make sure...
> > > reboot...
> > > test...      pff the tension...
> > > yay, still good!
> > > 
> > > Andrei; would you please verify.
> > 
> > I have corrupted files.
> 
> drad; and with this patch:
>   http://lkml.org/lkml/2006/12/20/112

Hash check on download completion found bad chunks, consider using
"safe_sync".

> 
> /me goes rebuild his kernel and try more than 3 times
> 

