Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269173AbUJKTAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269173AbUJKTAZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 15:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269175AbUJKTAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 15:00:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16307 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269173AbUJKTAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 15:00:23 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16746.55283.192591.718383@segfault.boston.redhat.com>
Date: Mon, 11 Oct 2004 14:58:59 -0400
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>
Subject: Re: [patch rfc] towards supporting O_NONBLOCK on regular files
In-Reply-To: <1097519553.2128.115.camel@sisko.scot.redhat.com>
References: <16733.50382.569265.183099@segfault.boston.redhat.com>
	<20041005112752.GA21094@logos.cnet>
	<16739.61314.102521.128577@segfault.boston.redhat.com>
	<20041006120158.GA8024@logos.cnet>
	<1097119895.4339.12.camel@orbit.scot.redhat.com>
	<20041007101213.GC10234@logos.cnet>
	<1097519553.2128.115.camel@sisko.scot.redhat.com>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: [patch rfc] towards supporting O_NONBLOCK on regular files; "Stephen C. Tweedie" <sct@redhat.com> adds:

sct> Hi, On Thu, 2004-10-07 at 11:12, Marcelo Tosatti wrote:

>> Oh yes, theres also the indirect blocks which we might need to read from
>> disk.

sct> Right.

>> Now the question is, how strict should the O_NONBLOCK implementation be
>> in reference to "not blocking" ?

sct> Well, I suspect that depends on the application.  But if you've got an
sct> app that really wants to make sure its hot path is as fast as possible
sct> (eg. a high-throughput server multiplexing disk IO and networking
sct> through a single event loop), then ideally the app would want to punt
sct> any blocking disk IO to another thread.

sct> So it's a matter of significant extra programing for a small extra
sct> reduction in app blocking potential.

sct> I think it's worth getting this right in the long term, though.
sct> Getting readahead of indirect blocks right has other benefits too ---
sct> eg. we may be able to fix the situation where we end up trying to read
sct> indirect blocks before we've even submitted the IO for the previous
sct> data blocks, breaking the IO pipeline ordering.

So for the short term, are you an advocate of the patch posted?

-Jeff
