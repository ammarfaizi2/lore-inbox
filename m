Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030426AbWHXRiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbWHXRiX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 13:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030422AbWHXRiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 13:38:23 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:44969 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030418AbWHXRiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 13:38:22 -0400
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: Re: [PATCH 1/18] 2.6.17.9 perfmon2 patch for review: introduction
References: <200608230805.k7N85qo2000348@frankl.hpl.hp.com>
	<20060823152831.GC32725@infradead.org>
	<20060823155715.GA5204@martell.zuzino.mipt.ru>
	<20060823160458.GA17712@infradead.org>
	<20060823115857.89f8d47b.akpm@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       Stephane Eranian <eranian@frankl.hpl.hp.com>,
       linux-kernel@vger.kernel.org, eranian@hpl.hp.com
Date: Thu, 24 Aug 2006 10:38:24 -0700
In-Reply-To: <20060823115857.89f8d47b.akpm@osdl.org> (Andrew Morton's message
	of "Wed, 23 Aug 2006 11:58:57 -0700")
Message-ID: <7vac5u9gq7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Wed, 23 Aug 2006 17:04:58 +0100
> Christoph Hellwig <hch@infradead.org> wrote:
>
>> > Padding with zeros makes it even more useful:
>> > 
>> > 	[PATCH 00/17]
>> > 	[PATCH 01/17]
>> > 		...
>> > 	[PATCH 17/17]
>> 
>> To be honest I utterly hate that convention
>
> It's so they'll correctly alphasort at the recipient's end.
>
> I doubt if many MUAs do numeric sorting..

I wonder if 'git-format-patch --numbered' should be updated to
do the zero padding.  Right now we don't.

It should be a trivial patch to do if somebody is so inclined
(it is around ll.133 in log-tree.c).

