Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264889AbUD2QhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264889AbUD2QhH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 12:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbUD2QhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 12:37:07 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:31965 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264889AbUD2QhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 12:37:05 -0400
Message-ID: <40912F15.4030300@nortelnetworks.com>
Date: Thu, 29 Apr 2004 12:36:37 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       brettspamacct@fastclick.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <409021D3.4060305@fastclick.com><20040428170106.122fd94e.akpm@osdl.org><409047E6.5000505@pobox.com><40905127.3000001@fastclick.com><20040428180038.73a38683.akpm@osdl.org><4090595D.6050709@pobox.com> <20040428184008.226bd52d.akpm@osdl.org> <44780000.1083255853@flay>
In-Reply-To: <44780000.1083255853@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:

> The latency for interactive stuff is definitely more noticeable though, and
> thus arguably more important. Perhaps we should be tying the scheduler in
> more tightly with the VM - we've already decided there which apps are 
> "interactive" and thus need low latency ... shouldn't we be giving a boost
> to their RAM pages as well, and favour keeping those paged in over other
> pages (whether other apps, or cache) logically? It's all latency still ...

I like this idea.  Maybe make it more general though--tasks with high scheduler priority also get 
more of a memory priority boost.  This will factor in the static priority as well as the 
interactivity bonus.

Chris
