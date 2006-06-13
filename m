Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWFMMPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWFMMPm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 08:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWFMMPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 08:15:42 -0400
Received: from [213.46.243.16] ([213.46.243.16]:26964 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S932080AbWFMMPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 08:15:41 -0400
Subject: Re: [PATCH 1/6] mm: tracking shared dirty pages
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andi Kleen <ak@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <p73zmghqn2z.fsf@verdi.suse.de>
References: <20060613112120.27913.71986.sendpatchset@lappy>
	 <20060613112131.27913.43169.sendpatchset@lappy>
	 <p73zmghqn2z.fsf@verdi.suse.de>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 14:15:14 +0200
Message-Id: <1150200914.20886.135.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 14:03 +0200, Andi Kleen wrote:
> Peter Zijlstra <a.p.zijlstra@chello.nl> writes:
> 
> > From: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > 
> > People expressed the need to track dirty pages in shared mappings.
> 
> Why only shared mappings? Anonymous pages can be dirty too
> and would need to be written to swap then before making progress.

Anonymous pages are per definition dirty, as they don't have a
persistent backing store. Each eviction of an anonymous page requires IO
to swap space. On swap-in pages are removed from the swap space to make
place for other pages.

Peter

