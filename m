Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWI3ROF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWI3ROF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 13:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWI3ROE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 13:14:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:32394 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751309AbWI3ROA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 13:14:00 -0400
Date: Sat, 30 Sep 2006 10:13:39 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Dong Feng <middle.fengdong@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Paul Mackerras <paulus@samba.org>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: How is Code in do_sys_settimeofday() safe in case of SMP and
 Nest Kernel Path?
In-Reply-To: <200609301703.45364.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0609301013040.3519@schroedinger.engr.sgi.com>
References: <a2ebde260609290733m207780f0t8601e04fcf64f0a6@mail.gmail.com>
 <a2ebde260609290916j3a3deb9g33434ca5d93e7a84@mail.gmail.com>
 <451E8143.5030300@yahoo.com.au> <200609301703.45364.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2006, Andi Kleen wrote:

> > Did you get to the bottom of this yet? It looks like you're right,
> > and I suggest a seqlock might be a good option.
> 
> It basically doesn't matter because nobody changes the time zone after boot.

Then we need to change to comments to explain the situation.

