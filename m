Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWBZSl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWBZSl0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 13:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWBZSl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 13:41:26 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:51367 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751384AbWBZSlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 13:41:25 -0500
Date: Sun, 26 Feb 2006 12:39:31 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: OOM-killer too aggressive?
In-reply-to: <5KvnZ-4uN-27@gated-at.bofh.it>
To: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4401F5E3.3090003@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5KvnZ-4uN-27@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> DMA free:44kB min:32kB low:40kB high:48kB active:0kB inactive:0kB
> present:15728kB pages_scanned:0 all_unreclaimable? yes

I think the big question is who used up all the DMA zone.. Surely not 
the floppy driver..

> So it will try to allocate half its first request if that fails, then
> fall back to non-DMA memory as a last resort, but doesn't get a chance
> because the OOM killer gets invoked.  Maybe we need a new flag that says
> "fail me immediately if no memory available"?

I think __GFP_NORETRY already does this.. There is also __GFP_NOWARN 
which suppresses the allocation failure warning, not sure if we want 
that or not..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

