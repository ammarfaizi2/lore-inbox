Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVBOQg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVBOQg2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 11:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVBOQg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 11:36:28 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:39380 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261782AbVBOQgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 11:36:14 -0500
Date: Tue, 15 Feb 2005 08:35:29 -0800
From: Paul Jackson <pj@sgi.com>
To: Robin Holt <holt@sgi.com>
Cc: holt@sgi.com, haveblue@us.ibm.com, raybry@sgi.com, taka@valinux.co.jp,
       hugh@veritas.com, akpm@osdl.org, marcello@cyclades.com,
       raybry@austin.rr.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2.6.11-rc2-mm2 7/7] mm: manual page migration --
 sys_page_migrate
Message-Id: <20050215083529.2f80c294.pj@sgi.com>
In-Reply-To: <20050215162135.GA22646@lnx-holt.americas.sgi.com>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
	<20050212032620.18524.15178.29731@tomahawk.engr.sgi.com>
	<1108242262.6154.39.camel@localhost>
	<20050214135221.GA20511@lnx-holt.americas.sgi.com>
	<1108407043.6154.49.camel@localhost>
	<20050214220148.GA11832@lnx-holt.americas.sgi.com>
	<20050215074906.01439d4e.pj@sgi.com>
	<20050215162135.GA22646@lnx-holt.americas.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin wrote:
> That seems like it is insane!

Thank-you, thank-you.  <blush>

What about the suggestion I had that you sort of skipped over, which
amounted to changing the system call from a node array to just one
node:

    sys_page_migrate(pid, va_start, va_end, count, old_nodes, new_nodes);

to:

    sys_page_migrate(pid, va_start, va_end, old_node, new_node);

Doesn't that let you do all you need to?  Is it insane too?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
