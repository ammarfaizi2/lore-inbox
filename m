Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVBRQZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVBRQZo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 11:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVBRQZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 11:25:44 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:34508 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261393AbVBRQZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 11:25:37 -0500
Date: Fri, 18 Feb 2005 08:25:18 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: raybry@sgi.com, ak@suse.de, ak@muc.de, raybry@austin.rr.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
 II
Message-Id: <20050218082518.03f46371.pj@sgi.com>
In-Reply-To: <20050218130232.GB13953@wotan.suse.de>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
	<m1vf8yf2nu.fsf@muc.de>
	<42114279.5070202@sgi.com>
	<20050215121404.GB25815@muc.de>
	<421241A2.8040407@sgi.com>
	<20050215214831.GC7345@wotan.suse.de>
	<4212C1A9.1050903@sgi.com>
	<20050217235437.GA31591@wotan.suse.de>
	<4215A992.80400@sgi.com>
	<20050218130232.GB13953@wotan.suse.de>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> Problem is what happens
> when some memory is in some other node due to memory pressure fallbacks.
> Your scheme would not migrate this memory at all. 

The arrays of old and new nodes handle this fine.
Include that 'other node' in the array of old nodes,
and the corresponding new node, where those pages
should migrate, in the array of new nodes.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
