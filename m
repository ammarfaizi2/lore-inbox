Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVBVVei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVBVVei (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 16:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVBVVeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 16:34:37 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:47336 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S261259AbVBVVeZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 16:34:25 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch -mm series] ia64 specific /dev/mem handlers
References: <16923.193.128608.607599@jaguar.mkp.net>
	<20050222020309.4289504c.akpm@osdl.org>
	<yq0ekf8lksf.fsf@jaguar.mkp.net>
	<20050222175225.GK28741@parcelfarce.linux.theplanet.co.uk>
	<20050222112513.4162860d.akpm@osdl.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 22 Feb 2005 16:34:23 -0500
In-Reply-To: <20050222112513.4162860d.akpm@osdl.org>
Message-ID: <yq0acpwl1nk.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

Andrew> Matthew Wilcox <matthew@wil.cx> wrote:
>> 
>> On Tue, Feb 22, 2005 at 09:41:04AM -0500, Jes Sorensen wrote:
>> > >> + if (page->flags & PG_uncached)
>> > 
>> > Andrew> dude.  That ain't gonna work ;)
>> > 
>> > Pardon my lack of clue, but why not?

Andrew> 	if (page->flags & (1<<PG_uncached))

Andrew> would have been correcter.

DOH!

Desperately seeking a bulk supply of those brown paper bags!

>> I think you're supposed to always use test_bit() to check page
>> flags

Andrew> Yup.  Add PageUncached macros to page-flags.h.

Mmmmm another butt ugly StUdLyCaPs macro coming soon.

Thanks,
Jes
