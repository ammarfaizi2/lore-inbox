Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267767AbUHEPnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267767AbUHEPnM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 11:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267711AbUHEPmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 11:42:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35516 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267763AbUHEPmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 11:42:33 -0400
Date: Thu, 5 Aug 2004 11:42:28 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] increase mlock limit to 32k
In-Reply-To: <20040805081445.1c4b085e.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.44.0408051141050.1955-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2004, Randy.Dunlap wrote:

> Please s/32768/MLOCK_LIMIT/g (above)
> 
> and use:
> #define MLOCK_LIMIT		32768

I got thrown off by the fact that asm-*/resource.h don't
include any other files, but you're right that I can just
#define the value in include/linux/resource.h and work
from there.

Andrew, I'll send you an updated patch (not an incremental)
later today.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

