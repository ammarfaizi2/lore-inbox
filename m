Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264895AbUD2Q5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264895AbUD2Q5R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 12:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264897AbUD2Q5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 12:57:17 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:23178 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264895AbUD2Q5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 12:57:14 -0400
Date: Thu, 29 Apr 2004 09:56:59 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       brettspamacct@fastclick.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <59450000.1083257819@flay>
In-Reply-To: <40912F15.4030300@nortelnetworks.com>
References: <409021D3.4060305@fastclick.com><20040428170106.122fd94e.akpm@osdl.org><409047E6.5000505@pobox.com><40905127.3000001@fastclick.com><20040428180038.73a38683.akpm@osdl.org><4090595D.6050709@pobox.com> <20040428184008.226bd52d.akpm@osdl.org> <44780000.1083255853@flay> <40912F15.4030300@nortelnetworks.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The latency for interactive stuff is definitely more noticeable though, and
>> thus arguably more important. Perhaps we should be tying the scheduler in
>> more tightly with the VM - we've already decided there which apps are 
>> "interactive" and thus need low latency ... shouldn't we be giving a boost
>> to their RAM pages as well, and favour keeping those paged in over other
>> pages (whether other apps, or cache) logically? It's all latency still ...
> 
> I like this idea.  Maybe make it more general though--tasks with high scheduler priority also get more of a memory priority boost.  This will factor in the static priority as well as the interactivity bonus.

Yeah, see also my other mail in that thread - if we moved to file-object (address_space) and task anon (mm) based tracking, it should be much easier.
Also fits in nicely with Hugh's anon_mm code.

M.
 
