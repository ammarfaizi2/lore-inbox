Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266191AbUGAQ7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266191AbUGAQ7i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 12:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUGAQ7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 12:59:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47839 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266166AbUGAQ5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 12:57:08 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16612.16858.959279.469244@segfault.boston.redhat.com>
Date: Thu, 1 Jul 2004 12:54:50 -0400
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netconsole hangs w/ alt-sysrq-t
In-Reply-To: <20040701165201.GF25826@waste.org>
References: <16527.42815.447695.474344@segfault.boston.redhat.com>
	<20040428140353.GC28459@waste.org>
	<16527.47765.286783.249944@segfault.boston.redhat.com>
	<20040428142753.GE28459@waste.org>
	<16527.63123.869014.733258@segfault.boston.redhat.com>
	<16604.18881.850162.785970@segfault.boston.redhat.com>
	<20040625232711.GE25826@waste.org>
	<16608.12233.39964.940020@segfault.boston.redhat.com>
	<20040628151954.GH25826@waste.org>
	<16608.20014.220537.339589@segfault.boston.redhat.com>
	<20040701165201.GF25826@waste.org>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: netconsole hangs w/ alt-sysrq-t; Matt Mackall <mpm@selenic.com> adds:

mpm> On Mon, Jun 28, 2004 at 12:58:22PM -0400, Jeff Moyer wrote:
>> ==> Regarding Re: netconsole hangs w/ alt-sysrq-t; Matt Mackall
>> <mpm@selenic.com> adds:
mpm> No, I think we get to this on the non-NAPI route as well. The ->poll
mpm> check keeps us from filtering twice.
>> I'll have to take your word for it on this one, as I can't find a way
>> into this code for the non-napi case.  Would anyone care to give an
>> authoritative answer on this?

mpm> I could be mistaken, but that's my recollection from last summer.
mpm> Hopefully I'll have some spare cycles for this next week.
 
>> One other thing we might consider is adding a call to
>> touch_nmi_watchdog() to zap_completion_queue.

mpm> Not sure how I feel about that yet. If we can't get out of the guts of
mpm> netpoll in a timely fashion, then perhaps that's an indication that
mpm> the watchdog should indeed fire. Describe the scenario where you think
mpm> we should do this, please.

Alt-Sysrq-t from the keyboard on a heavily-loaded UP system.

-Jeff
