Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbUD2QZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUD2QZN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 12:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264888AbUD2QZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 12:25:13 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:50835 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264881AbUD2QZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 12:25:09 -0400
Date: Thu, 29 Apr 2004 09:24:13 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
cc: brettspamacct@fastclick.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <44780000.1083255853@flay>
In-Reply-To: <20040428184008.226bd52d.akpm@osdl.org>
References: <409021D3.4060305@fastclick.com><20040428170106.122fd94e.akpm@osdl.org><409047E6.5000505@pobox.com><40905127.3000001@fastclick.com><20040428180038.73a38683.akpm@osdl.org><4090595D.6050709@pobox.com> <20040428184008.226bd52d.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  These are at the heart of the thread (or my point, at 
>> least) -- BloatyApp may be Oracle with a huge cache of its own, for 
>> which swapping out may be a huge mistake.  Or Mozilla.  After some 
>> amount of disk IO on my 512MB machine, Mozilla would be swapped out... 
>> when I had only been typing an email minutes before.
> 
> OK, so it takes four seconds to swap mozilla back in, and you noticed it.
> 
> Did you notice that those three kernel builds you just did ran in twenty
> seconds less time because they had more cache available?  Nope.

The latency for interactive stuff is definitely more noticeable though, and
thus arguably more important. Perhaps we should be tying the scheduler in
more tightly with the VM - we've already decided there which apps are 
"interactive" and thus need low latency ... shouldn't we be giving a boost
to their RAM pages as well, and favour keeping those paged in over other
pages (whether other apps, or cache) logically? It's all latency still ...

M.

