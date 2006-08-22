Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWHVIBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWHVIBb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 04:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWHVIBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 04:01:31 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:34223 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1751275AbWHVIBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 04:01:30 -0400
Message-Id: <44EAD613.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 22 Aug 2006 10:01:55 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, "Andi Kleen" <ak@suse.de>,
       <linux-kernel@vger.kernel.org>, "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
References: <20060820013121.GA18401@fieldses.org>
 <44E97353.76E4.0078.0@novell.com>
 <20060821094718.79c9a31a.rdunlap@xenotime.net>
 <20060821212043.332fdd0f.akpm@osdl.org>
In-Reply-To: <20060821212043.332fdd0f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andrew Morton <akpm@osdl.org> 22.08.06 06:20 >>>
>On Mon, 21 Aug 2006 09:47:18 -0700
>"Randy.Dunlap" <rdunlap@xenotime.net> wrote:
>
>> > The 'stuck' unwinder issue at hand already has a fix, though planned to
>> > be merged for 2.6.19 only. The crash after switching to the legacy
>> > stack trace code is bad, though, but has little to do with the unwinder
>> > additions/changes. The way that code reads the stack is just
>> > inappropriate in contexts where things must be expected to be broken.
>> 
>> "merged for 2.6.19" meaning:
>> - in (before) 2.6.19, or
>> - after 2.6.19 is released
>> 
>> If "after," then it will likely need to be added to -stable also,
>> so it might as well go in "before" 2.6.19 is released.
>
>Precisely.

My understanding of 'for' is that Andi will send to Linus after in the 2.6.19
merge window.

>Guys, this unwinder change has been quite problematic.  We really cannot
>let this badness out into 2.6.18 - it degrades our ability to debug every
>subsystem in the entire kernel.  Would marking it CONFIG_BROKEN get us back
>to 2.6.17 behaviour?

I'd prefer pushing into 2.6.18 some of the patches currently scheduled for
2.6.19 over marking it CONFIG_BROKEN. But that's clearly not my decision.

Jan
