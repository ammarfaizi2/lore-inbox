Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVBODRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVBODRf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 22:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVBODRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 22:17:35 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:57815 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261605AbVBODRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 22:17:33 -0500
Date: Mon, 14 Feb 2005 19:16:51 -0800
From: Paul Jackson <pj@sgi.com>
To: Ray Bryant <raybry@sgi.com>
Cc: ak@muc.de, holt@sgi.com, marcelo.tosatti@cyclades.com,
       raybry@austin.rr.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
Message-Id: <20050214191651.64fc3347.pj@sgi.com>
In-Reply-To: <42113921.7070807@sgi.com>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
	<m1vf8yf2nu.fsf@muc.de>
	<20050212155426.GA26714@logos.cnet>
	<20050212212914.GA51971@muc.de>
	<20050214163844.GB8576@lnx-holt.americas.sgi.com>
	<20050214191509.GA56685@muc.de>
	<42113921.7070807@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray wrote:
> [Thus the disclaimer in
> the overview note that we have figured all the interaction with
> memory policy stuff yet.]

Does the same disclaimer apply to cpusets?

Unless it causes some undo pain, I would think that page migration
should _not_ violate a tasks cpuset.  I guess this means that a typical
batch manager would move a task to its new cpuset on the new nodes, or
move the cpuset containing some tasks to their new nodes, before asking
the page migrator to drag along the currently allocated pages from the
old location.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
