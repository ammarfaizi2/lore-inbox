Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267508AbUJNXog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267508AbUJNXog (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 19:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268031AbUJNXjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 19:39:25 -0400
Received: from brown.brainfood.com ([146.82.138.61]:46978 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S268076AbUJNXgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 19:36:51 -0400
Date: Thu, 14 Oct 2004 18:36:47 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Andi Kleen <ak@suse.de>
cc: "Martin K. Petersen" <mkp@wildopensource.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, akpm@osdl.org,
       tony.luck@intel.com
Subject: Re: [PATCH] General purpose zeroed page slab
In-Reply-To: <20041014180427.GA7973@wotan.suse.de>
Message-ID: <Pine.LNX.4.58.0410141836270.1221@gradall.private.brainfood.com>
References: <yq1oej5s0po.fsf@wilson.mkp.net> <20041014180427.GA7973@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004, Andi Kleen wrote:

> Also that's pretty dumb. How about keeping track how much of the
> page got non zeroed (e.g. by using a few free words in struct page
> for a coarse grained dirty bitmap)
>
> Then you could memset on free only the parts that got actually
> changed, and never waste cache lines for anything else.

That will fail when a struct is placed in the page, and only the beginning and
end of the struct was changed.

