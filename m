Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263996AbTDYVAl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 17:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTDYVAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 17:00:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11278 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263996AbTDYVAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 17:00:40 -0400
Message-ID: <3EA9A4B8.2030304@zytor.com>
Date: Fri, 25 Apr 2003 14:12:24 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: TASK_UNMAPPED_BASE & stack location
References: <459930000.1051302738@[10.10.2.4]> <b8c7no$u59$1@cesium.transmeta.com> <1750000.1051305030@[10.10.2.4]>
In-Reply-To: <1750000.1051305030@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>>Is there any good reason we can't remove TASK_UNMAPPED_BASE, and just
>>>shove libraries directly above the program text? Red Hat seems to have
>>>patches to dynamically tune it on a per-processes basis anyway ...
>>>
>>>Moreover, can we put the stack back where it's meant to be, below the
>>>program text, in that wasted 128MB of virtual space? Who really wants 
>>>
>>>>128MB of stack anyway (and can't fix their app)?
>>
>>That space is NULL pointer trap zone.  NULL pointer trapping -> good.
> 
> 
> 128Mb of it? The bottom page, or even a few Mb, sure ... 
> but 128Mb seems somewhat excessive ...
> 

Perhaps, but large data structures can easily generate reasonably large
values when indirected.

	-hpa


