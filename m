Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265770AbUGAOb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265770AbUGAOb3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 10:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbUGAO3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 10:29:47 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:44037 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265530AbUGAO26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 10:28:58 -0400
Message-ID: <40E4249C.5090400@techsource.com>
Date: Thu, 01 Jul 2004 10:50:04 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Joshua <jhudson@cyberspace.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore floppy boot image
References: <40E3319D.3050100@techsource.com>	<Pine.SUN.3.96.1040630174704.20503A-100000@grex.cyberspace.org> <20040630145506.46d3af16.rddunlap@osdl.org>
In-Reply-To: <20040630145506.46d3af16.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Randy.Dunlap wrote:
> On Wed, 30 Jun 2004 17:52:30 -0400 (EDT) Joshua wrote:
> 
> | Thanks for the time in reading the patch.
> | 
> | Hmm. pop %ax after the jmp is a clear bug. Must have been a zero
> | on the stack when I tested it. <g>
> | 
> | For the clobbering of al just before kernel entry, that is badly arranged
> | code although it doesn't matter (mov $0, %al turns out to be no-op).
> 
> No-op should be some form/variant of xchg %ax,%ax 
> (not mov to %al -- the latter needs to do something.)

He didn't mean it was a "nop".  He meant that the operation had no 
effect because moving zero to a register which already contains zero 
accomplishes nothing.

