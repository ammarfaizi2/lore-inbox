Return-Path: <linux-kernel-owner+w=401wt.eu-S932777AbWLSKsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932777AbWLSKsN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 05:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932773AbWLSKsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 05:48:13 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48203 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932777AbWLSKsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 05:48:12 -0500
Date: Tue, 19 Dec 2006 02:47:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
Message-Id: <20061219024715.b1d3728b.akpm@osdl.org>
In-Reply-To: <20061219023255.f5241bb0.akpm@osdl.org>
References: <1166314399.7018.6.camel@localhost>
	<20061217040620.91dac272.akpm@osdl.org>
	<1166362772.8593.2.camel@localhost>
	<20061217154026.219b294f.akpm@osdl.org>
	<1166460945.10372.84.camel@twins>
	<Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	<45876C65.7010301@yahoo.com.au>
	<Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>
	<45878BE8.8010700@yahoo.com.au>
	<Pine.LNX.4.64.0612182313550.3479@woody.osdl.org>
	<Pine.LNX.4.64.0612182342030.3479@woody.osdl.org>
	<4587B762.2030603@yahoo.com.au>
	<20061219023255.f5241bb0.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006 02:32:55 -0800
Andrew Morton <akpm@osdl.org> wrote:

> <spots a race in do_no_page()>
> 
> If a write-fault races with a read-fault and the write-fault loses, we forget
> to mark the page dirty.

No that isn't right, is it.  The writer just retakes the fault and
all the right things happen.  Ho hum.
