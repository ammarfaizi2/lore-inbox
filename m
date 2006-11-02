Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752775AbWKBJgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbWKBJgS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 04:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWKBJgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 04:36:18 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:30080
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1752776AbWKBJgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 04:36:16 -0500
Message-Id: <4549CA86.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Thu, 02 Nov 2006 09:37:58 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Martin Lorenz" <martin@lorenz.eu.org>, "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc3: more DWARFs and strange messages
References: <20061028200151.GC5619@gimli> <20061031160815.GM27390@gimli>
 <454787AB.76E4.0078.0@novell.com> <200610311828.52980.ak@suse.de>
 <20061101152746.GD6438@gimli>
In-Reply-To: <20061101152746.GD6438@gimli>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>what is a reasonable kstack parameter to be informative for you?

This unfortunately depends on the depth of the stack that is in use
at the point the dump is taken. The only safe value would be to
dump the full stack size (kstack=1024 for 4k stack, kstack=2048
for 8k ones), but since it'll stop at a stack boundary perhaps that's
what you should go with.

As to Andi's remark regarding WARN_ON() - you'd have to address
that issue in a private patch first, or the addition of the kstack=
parameter will be useless. I presume it's likely you don't have the
time to do that...

Jan
