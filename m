Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWA0GqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWA0GqG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 01:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWA0GqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 01:46:06 -0500
Received: from [85.8.13.51] ([85.8.13.51]:5849 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751336AbWA0GqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 01:46:03 -0500
Message-ID: <43D9C19F.7090707@drzeus.cx>
Date: Fri, 27 Jan 2006 07:45:51 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.7-2.1.fc4.nr (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: How to map high memory for block io
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having some problems getting high memory support to work smoothly in
my driver. The documentation doesn't indicate what I might be doing
wrong so I'll have to ask here.

The problem seems to be that kmap & co maps a single page into kernel
memory. So when I happen to cross page boundaries I start corrupting
some unrelated parts of the kernel. I would prefer not having to
consider page boundaries in an already messy PIO loop, so I've been
trying to find either a routine to map an entire sg entry or some way to
force the block layer to not give me stuff crossing pages.

As you can guess I have not found anything that can do what I want, so
some pointers would be nice.

Rgds
Pierre
