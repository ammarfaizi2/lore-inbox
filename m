Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267333AbUJRUaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267333AbUJRUaF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 16:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUJRU26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 16:28:58 -0400
Received: from vanessarodrigues.com ([192.139.46.150]:13543 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S267452AbUJRSyP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:54:15 -0400
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, akpm@osdl.org, tony.luck@intel.com
Subject: Re: [PATCH] General purpose zeroed page slab
From: "Martin K. Petersen" <mkp@wildopensource.com>
Organization: Wild Open Source, Inc.
References: <yq1oej5s0po.fsf@wilson.mkp.net>
	<20041014180427.GA7973@wotan.suse.de> <yq1ekjvrjd6.fsf@wilson.mkp.net>
	<20041018184210.GI16153@parcelfarce.linux.theplanet.co.uk>
Date: Mon, 18 Oct 2004 14:54:13 -0400
In-Reply-To: <20041018184210.GI16153@parcelfarce.linux.theplanet.co.uk> (Matthew
 Wilcox's message of "Mon, 18 Oct 2004 19:42:10 +0100")
Message-ID: <yq1acujrh62.fsf@wilson.mkp.net>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Matthew" == Matthew Wilcox <matthew@wil.cx> writes:

Matthew> It's probably worth doing this with a static cachep in slab.c
Matthew> and only exposing a get_zeroed_page() / free_zeroed_page()
Matthew> interface, with the latter doing the memset to 0.  

*nod*


Matthew> I disagree with Andi over the dumbness of zeroing the whole
Matthew> page.  That makes it cache-hot, which is what you want from a
Matthew> page you allocate from slab.

Yeah, plus the housekeeping may be more of a hassle than it's worth.

We'll see...

-- 
Martin K. Petersen	Wild Open Source, Inc.
mkp@wildopensource.com	http://www.wildopensource.com/
